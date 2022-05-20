//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import UIKit
import Utilities

public struct TripleLineHeaderModel {
    var title: String
    var subtitle: String
    var caption: String
    
    public init(_ title: String, _ subtitle: String, _ caption: String) {
        self.title = title
        self.subtitle = subtitle
        self.caption = caption
    }
}

public class TripleLineHeader: UIStackView {
    public private(set) lazy var title: UILabel = {
        let title = UILabel()
        title.font =  .largeTitle
        title.textColor = .appWhite
        return title
    }()
    
    public private(set) lazy var subtitle: UILabel = {
        let title = UILabel()
        title.font =  .title
        title.textColor = .appWhite
        return title
    }()
    
    public private(set) lazy var caption: UILabel = {
        let title = UILabel()
        title.font =  .headline
        title.textColor = .appWhite
        return title
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        axis = .vertical
        spacing = 0
        addArrangedSubview(title)
        addArrangedSubview(subtitle)
        addArrangedSubview(caption)
    }
    
    public func configure(model: TripleLineHeaderModel) {
        self.title.text = model.title
        self.subtitle.text = model.subtitle
        self.caption.text = model.caption
    }
}
