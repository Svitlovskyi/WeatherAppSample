//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import UIKit

public class TripleHeaderCell: UITableViewCell {
    public private(set) var tripleHeader: TripleLineHeader = TripleLineHeader()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        tripleHeader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tripleHeader)
        let constraints: [NSLayoutConstraint] = [
            tripleHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            tripleHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            tripleHeader.topAnchor.constraint(equalTo: topAnchor),
            tripleHeader.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
