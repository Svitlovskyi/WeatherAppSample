//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import Foundation
import UIKit

open class BaseViewPresenter<T:UIViewController> {
    public weak var viewController: T?
    
    public init(viewController: T) {
        self.viewController = viewController
    }
    
    public func alert(with title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
