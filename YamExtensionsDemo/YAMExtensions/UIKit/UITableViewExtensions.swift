//
//  UITableView+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension YamEx where Base: TableView {
    
    func update(with block: (_ tableView: UITableView) -> ()) {
        base.beginUpdates()
        block(base)
        base.endUpdates()
    }
    
    func scrollTo(row: NSInteger, in section: NSInteger, at ScrollPosition: UITableViewScrollPosition, animated: Bool){
        let indexPath = IndexPath(row: row, section: section)
        base.scrollToRow(at: indexPath, at: ScrollPosition, animated: animated)
    }
    
    func insert(row: NSInteger, in section: NSInteger, with rowAnimation: UITableViewRowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        base.insertRows(at: [indexPath], with: rowAnimation)
    }
    
    func reload(row: NSInteger, in section: NSInteger, with rowAnimation: UITableViewRowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        base.reloadRows(at: [indexPath], with: rowAnimation)
    }
    
    func delete(row: NSInteger, in section: NSInteger, with rowAnimation: UITableViewRowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        base.deleteRows(at: [indexPath], with: rowAnimation)
    }
    
    func insert(at indexPath: IndexPath, with rowAnimation: UITableViewRowAnimation) {
        base.insertRows(at: [indexPath], with: rowAnimation)
    }
    
    func reload(at indexPath: IndexPath, with rowAnimation: UITableViewRowAnimation) {
        base.reloadRows(at: [indexPath], with: rowAnimation)
    }
    
    func delete(at indexPath: IndexPath, with rowAnimation: UITableViewRowAnimation) {
        base.deleteRows(at: [indexPath], with: rowAnimation)
    }
    
    func reload(section: NSInteger, with rowAnimation: UITableViewRowAnimation) {
        base.reloadSections([section], with: rowAnimation)
    }
    
    func clearSelectedRows(animated: Bool) {
        guard let indexs = base.indexPathsForSelectedRows else { return }
        for path in indexs {
            base.deselectRow(at: path, animated: animated)
        }
    }
}
