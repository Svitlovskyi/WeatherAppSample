//
//  File.swift
//  
//
//  Created by Maksym on 23/01/2022.
//

import Combine
import UIKit

class CombineTableViewDataSource<Element>: NSObject, UITableViewDataSource {

    let build: (UITableView, IndexPath, Element) -> UITableViewCell
    var elements: [Element] = []

    init(builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell) {
        build = builder
        super.init()
    }

    func pushElements(_ elements: [Element], to tableView: UITableView) {
        tableView.dataSource = self
        self.elements = elements
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        build(tableView, indexPath, elements[indexPath.row])
    }
}

public class CombineTableViewDelegate: NSObject, UITableViewDelegate {
    private var tableView: UITableView
    /// Footer
    var buildFooter: ((UITableView, Int) -> UIView?)?
    var footerSize: ((UITableView, Int) -> CGFloat)?
    /// Header
    var buildHeader: ((UITableView, Int) -> UIView?)?
    var headerSize: ((UITableView, Int) -> CGFloat)?
    
    init(for tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
    }
    
    func addFooter(builder: @escaping ((UITableView, Int) -> UIView?),
                   sizeBuilder: ((UITableView, Int) -> CGFloat)?) {
        tableView.delegate = self
        footerSize = sizeBuilder
        buildFooter = builder
        tableView.reloadData()
    }
    
    func addHeader(builder: @escaping ((UITableView, Int) -> UIView?),
                   sizeBuilder: ((UITableView, Int) -> CGFloat)?) {
        tableView.delegate = self
        headerSize = sizeBuilder
        buildHeader = builder
        tableView.reloadData()
        
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let buildFooter = buildFooter {
            return buildFooter(tableView, section)
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let footerSize = footerSize {
            return footerSize(tableView, section)
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let buildHeader = buildHeader {
            return buildHeader(tableView, section)
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let headerSize = headerSize {
            return headerSize(tableView, section)
        }
        return UITableView.automaticDimension
    }
}


public extension UITableView {
    private var combineDelegate: CombineTableViewDelegate {
        return CombineTableViewDelegate(for: self)
    }
    
    func items<Element>(_ builder: @escaping (UITableView, IndexPath, Element) -> UITableViewCell) -> ([Element]) -> Void {
        let dataSource = CombineTableViewDataSource(builder: builder)
        return { items in
            dataSource.pushElements(items, to: self)
        }
    }
    
    func footer<Footer>(_ builder:  @escaping (UITableView, Int) -> UIView?,
                        sizeForFooter: ((UITableView, Int) -> CGFloat)? = nil) -> (Footer) -> Void {
        return { footer in
            self.combineDelegate.addFooter(builder: builder, sizeBuilder: sizeForFooter)
        }
    }
    
    func header<Header>(_ builder:  @escaping (UITableView, Int) -> UIView?,
                        sizeForHeader: ((UITableView, Int) -> CGFloat)? = nil) -> (Header) -> Void {
        return { header in
            self.combineDelegate.addHeader(builder: builder, sizeBuilder: sizeForHeader)
        }
    }
}

