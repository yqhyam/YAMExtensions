//
//  UITableView+YamEx.swift
//  YamExtensionsDemo
//
//  Created by YaM on 2018/8/2.
//  Copyright © 2018年 compassic/YaM. All rights reserved.
//

import UIKit

extension UITableView {
    
    func update(with block: (_ tableView: UITableView) -> ()) {
        self.beginUpdates()
        block(self)
        self.endUpdates()
    }
    
    func scrollTo(row: NSInteger, in section: NSInteger, at ScrollPosition: UITableView.ScrollPosition, animated: Bool){
        let indexPath = IndexPath(row: row, section: section)
        self.scrollToRow(at: indexPath, at: ScrollPosition, animated: animated)
    }
    
    func insert(row: NSInteger, in section: NSInteger, with rowAnimation: UITableView.RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        self.insertRows(at: [indexPath], with: rowAnimation)
    }
    
    func reload(row: NSInteger, in section: NSInteger, with rowAnimation: UITableView.RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        self.reloadRows(at: [indexPath], with: rowAnimation)
    }
    
    func delete(row: NSInteger, in section: NSInteger, with rowAnimation: UITableView.RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        self.deleteRows(at: [indexPath], with: rowAnimation)
    }
    
    func insert(at indexPath: IndexPath, with rowAnimation: UITableView.RowAnimation) {
        self.insertRows(at: [indexPath], with: rowAnimation)
    }
    
    func reload(at indexPath: IndexPath, with rowAnimation: UITableView.RowAnimation) {
        self.reloadRows(at: [indexPath], with: rowAnimation)
    }
    
    func delete(at indexPath: IndexPath, with rowAnimation: UITableView.RowAnimation) {
        self.deleteRows(at: [indexPath], with: rowAnimation)
    }
    
    func reload(section: NSInteger, with rowAnimation: UITableView.RowAnimation) {
        self.reloadSections([section], with: rowAnimation)
    }
    
    func clearSelectedRows(animated: Bool) {
        guard let indexs = self.indexPathsForSelectedRows else { return }
        for path in indexs {
            self.deselectRow(at: path, animated: animated)
        }
    }
}
