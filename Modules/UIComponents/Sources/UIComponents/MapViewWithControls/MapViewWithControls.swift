//
//  File.swift
//  
//
//  Created by Maksym on 21/01/2022.
//
import UIKit
import MapKit
import Utilities

public class MapViewWithControls: UIStackView {
    public let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: MapViewType.allCases.map { $0.rawValue })
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self, action: #selector(segmentControlValueIsChanged(_:)), for: .valueChanged)
        return segmentControl
    }()
    
    public let button: UIButton = {
        let button = UIButton()
        button.setImage(Images.paperplane, for: .normal)
        return button
    }()
    
    public let mapView = MKMapView()
    
    private lazy var controlStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            segmentControl,
            button
        ])
        stack.distribution = .equalSpacing
        stack.directionalLayoutMargins = .init(top: 5, leading: 10, bottom: 5, trailing: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        axis = .vertical
        addArrangedSubview(mapView)
        addArrangedSubview(controlStack)
        segmentControl.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.7).isActive = true
        segmentControl.selectedSegmentIndex = 0
    }
    
    @objc private func segmentControlValueIsChanged(_ sender: UISegmentedControl) {
        guard let titleForChoosenSegment = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        guard let mapType = MapViewType(rawValue: titleForChoosenSegment) else { return }
        switch mapType {
        case .standard:
            mapView.mapType = .standard
        case .satellite:
            mapView.mapType = .satellite
        }
    }
}
