//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 24.01.2022.
//

import UIKit

internal class WeatherDetailView: UIStackView {
    private(set) var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        axis = .vertical
        addArrangedSubview(tableView)
    }
}

