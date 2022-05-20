import UIKit
import UIComponents
import MapKit
import BusinessLogicLayer
import WeatherDetailFeature

public class FavouriteFlowViewModel {
    let repository: FavouriteCitiesRepository
    
    var cellUiModels: [MapCellModel] {
        return repository.favourites.map({ return MapCellModel($0.cityName, $0.countryName, CLLocationCoordinate2D(latitude: $0.coordinates.lat, longitude: $0.coordinates.long) ) })
    }

    public init(repository: FavouriteCitiesRepository) {
        self.repository = repository
    }
}

public class FavouriteFlowViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    public var viewModel: FavouriteFlowViewModel?
    public var collectionView: UICollectionView!
    

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .zero
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-10, height: UIScreen.main.bounds.width/2-10)
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MapCell.self, forCellWithReuseIdentifier: "favoriteCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        setupLayout()
    }
    
    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.cellUiModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? MapCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel!.cellUiModels[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.viewModel?.repository.favourites[indexPath.row] else {
             return
        }
        
        let viewModel = WeatherDetailViewModel(coordinates: item.coordinates,
                                               cityName: item.cityName,
                                               countryName: item.countryName)
        let detailViewController = WeatherDetailViewController()
        detailViewController.viewModel = viewModel
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
