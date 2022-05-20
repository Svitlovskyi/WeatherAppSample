//
//  File.swift
//  
//
//  Created by Maksym on 22/01/2022.
//

import Foundation

public extension String {
    func localized(comment: String = "",
                   bundle: Bundle = .main) -> String {
        return NSLocalizedString(
            self,
            bundle: bundle,
            comment: comment
        )
    }
}
