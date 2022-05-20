//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import UIKit
import UIComponents
import NetworkLayer
import Combine

public class WeatherDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    public var viewModel: WeatherDetailViewModel!
    private let detailView = WeatherDetailView()
    private let cellId = "WeatherCell"
    var cancellable = Set<AnyCancellable>()
	lazy var titleView: UIStackView = {
        let label = UILabel()
        let sublabel = UILabel()
        label.text = viewModel.currentDate
        label.textColor = .appGray
        sublabel.text = viewModel.cityName
        label.font = .headlineSemibold
        sublabel.font = .headlineSemibold
        let stack = UIStackView(arrangedSubviews: [label, sublabel])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        detailView.tableView.register(EqualSpacingThreeTextCell.self, forCellReuseIdentifier: cellId)
        setupView()
        viewModel.setupBinding()

    }
    
    private func setupView() {
        view.backgroundColor = .black
        detailView.tableView.sectionHeaderHeight = 150
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self

        setupLayout()
        setupNavigationBar()
        
        viewModel.detailUiModel.$items.combineLatest(viewModel.detailUiModel.$footer, viewModel.detailUiModel.$header).sink(receiveValue: {_ in
            self.detailView.tableView.reloadData()
        }).store(in: &cancellable)
    }
    
    
    private func setupNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.titleView = titleView
    }
    
    private func setupLayout() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.isLayoutMarginsRelativeArrangement = true
        detailView.directionalLayoutMargins = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        view.addSubview(detailView)
        let constraints: [NSLayoutConstraint] = [
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
        
    @objc func footerAction() {
        self.viewModel.addRemoveFromFavourie()
    }
    
    //MARK: - Table view data source
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as? EqualSpacingThreeTextCell else {
            return UITableViewCell()
        }
        
        let item = self.viewModel.detailUiModel.items[indexPath.row]
        
        cell.configure(with: item)
        cell.leadingLabel.font = .body
        cell.centerLabel.font = .body
        cell.trailingLabel.font = .body
        cell.centerLabel.textColor = .appBlue
        cell.backgroundColor = .appBlack
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailUiModel.items.count
    }
    //MARK: - Table view delegate
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TripleLineHeader()
        header.configure(model: self.viewModel.detailUiModel.header)
        header.caption.textColor = .appGray
        header.directionalLayoutMargins = .init(top: 10, leading: 0, bottom: 30, trailing: 0)
        header.isLayoutMarginsRelativeArrangement = true
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UIButton()
        label.addTarget(self, action: #selector(self.footerAction), for: .touchDown)
        label.setAttributedTitle(self.viewModel.detailUiModel.footer, for: .normal)
        label.contentHorizontalAlignment = .left
        label.titleEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        return label
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

