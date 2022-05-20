//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import MapKit
import Utilities
import Combine

public class SearchViewController: UIViewController {
    private var viewModel = SearchViewModel()
    
	public var searchBar = UISearchController()
    public var tableView = UITableView()
    
    private var dataSource: AnyCancellable?
    private var cancllables = Set<AnyCancellable>()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchBar.delegate = self
        tableView.delegate = self
        dataSource = viewModel.$results.sink(receiveValue: tableView.items { tableView, indexPath, item in
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
            let result = self.viewModel.results[indexPath.row]
            cell.textLabel?.text = result.leftItem
            cell.detailTextLabel?.text = result.rightItem
            cell.detailTextLabel?.textColor = .appWhite
            cell.accessoryType = .disclosureIndicator
            
            return cell
        })
        
        
        viewModel.error.sink(receiveValue: { error in
            let alert = UIAlertController(
                title: "Error",
                message: error,
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: nil))
            self.present(alert, animated: true, completion: nil)
        }).store(in: &cancllables)
        
        setupView()
    }
    
    private func setupView() {
        overrideUserInterfaceStyle = .dark
        self.navigationController?.overrideUserInterfaceStyle = .dark
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchBar
        
        view.addSubview(tableView)
        searchBar.searchBar.tintColor = .appPurple
        searchBar.searchBar.searchTextField.leftView?.tintColor = .appPurple
		setupLayout()
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        NSLayoutConstraint.activate(constaints)
    }
}

extension SearchViewController: UISearchBarDelegate, UITableViewDelegate {
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text.isEmpty { return }
        viewModel.updateQueryFragmentWith(query: text)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.navigationController?.pushViewController(viewModel.buildDetailView(for: indexPath.row), animated: true)
    }
}
