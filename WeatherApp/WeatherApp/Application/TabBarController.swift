//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maksym on 21/01/2022.
//

import UIKit
import WeatherMapFeature
import SearchCityFeature
import FavouritesFlowLayoutFeature
import BusinessLogicLayer


class RootResolver {
    let di = DependencyInjector()
}

class AppTabBarController: UITabBarController {
    private let rootResolver = RootResolver()
    
    private lazy var mapViewController: WeatherMapViewController = {
        let weatherMapConfigurer = WeatherMapConfigurator()
        let viewController = WeatherMapViewController()
        weatherMapConfigurer.configure(viewController: viewController)
        return viewController
    }()
    
    private lazy var searchViewController: SearchViewController = {
        return SearchViewController()
    }()
    
    private lazy var favouritesViewController: FavouriteFlowViewController = {
        let viewController = FavouriteFlowViewController()
        let viewModel = FavouriteFlowViewModel(repository: rootResolver.di.favouritesRepository)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            configureTabItem(for: mapViewController, with: L.mapTab.localized(), with: Images.map),
            configureTabItem(for: searchViewController, with: L.searchTab.localized(), with: Images.magnifyingGlass),
            configureTabItem(for: favouritesViewController, with: L.favouriteTab.localized(), with: Images.star)
        ]
        
        tabBar.backgroundColor = .appBlack
        tabBar.unselectedItemTintColor = .appGray
        tabBar.tintColor = .appPurple
        setupObservingFavourites()
        
        self.favouritesViewController.tabBarItem.badgeValue = String(self.rootResolver.di.favouritesRepository.favourites.count)
    }
    
    func setupObservingFavourites() {
        NotificationCenter.default.addObserver(forName: .onFavouriteCityUpdate, object: nil, queue: .main, using: { notification in
            
            guard let collectionView = self.favouritesViewController.collectionView else { return }
            self.rootResolver.di.favouritesRepository.refresh()
            collectionView.reloadData()
            self.favouritesViewController.tabBarItem.badgeValue = String(self.rootResolver.di.favouritesRepository.favourites.count)
        })
    }
    
    func configureTabItem(for viewController: UIViewController,
                          with title: String,
                          with image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        return navigationController
    }
}

