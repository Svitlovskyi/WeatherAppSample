//
//  File.swift
//  
//
//  Created by Maksym on 21/01/2022.
//

import Foundation
import UIKit

public struct EqualSpacingThreeTextCellModel {
    let leadingText: String
    let centerText: String
    let trailingText: String
    
    public init(_ leadingText: String, _ centerText: String, _ trailingText: String) {
        self.leadingText = leadingText
        self.centerText = centerText
        self.trailingText = trailingText
    }
}

public class EqualSpacingThreeTextCell: UITableViewCell {
    public var leadingLabel: UILabel = UILabel()
    public var centerLabel: UILabel = UILabel()
    public var trailingLabel: UILabel = UILabel()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        leadingLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        trailingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leadingLabel)
        addSubview(centerLabel)
        addSubview(trailingLabel)
        setupLayout()
    }
    
    internal func setupLayout() {
        let constraints = [
            leadingLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            trailingLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            leadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func configure(with: EqualSpacingThreeTextCellModel) {
        self.leadingLabel.text = with.leadingText
        self.centerLabel.text = with.centerText
        self.trailingLabel.text = with.trailingText
    }
}
