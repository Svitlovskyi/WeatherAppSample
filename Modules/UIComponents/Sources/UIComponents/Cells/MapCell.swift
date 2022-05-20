//
//  MapCell.swift
//  
//
//  Created by Maksym on 21/01/2022.
//

import UIKit
import MapKit

public struct MapCellModel {
    let title: String
    let subtitle: String
    let localtion: CLLocationCoordinate2D
    
    public init(_ title: String, _ subtitle: String, _ location: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.localtion = location
    }
}

public class MapCell: UICollectionViewCell {
    private(set) var contentStack: MKMapView = {
        let mapView = MKMapView()
        mapView.isUserInteractionEnabled = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private(set) var title: UILabel = UILabel()
    private(set) var subtitle: UILabel = UILabel()
    
    private(set) lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            title, subtitle
        ])
        stack.axis = .vertical
        stack.backgroundColor = .appGray
        stack.spacing = 0
        stack.layoutMargins = .init(top: 10,
                                     left: 10,
                                     bottom: 10,
                                     right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        contentStack.layer.masksToBounds = true
        title.font = .headlineSemibold
        subtitle.font = .headline
        contentStack.mapType = .standard
        overrideUserInterfaceStyle = .dark
        setupLayout()
    }
    
    private func setupLayout() {
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        contentStack.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configure(with model: MapCellModel) {
        self.title.text = model.title
        self.subtitle.text = model.subtitle
        self.contentStack.setCenter(model.localtion, animated: false)
    }
}
