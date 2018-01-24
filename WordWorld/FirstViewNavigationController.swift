//
//  FirstViewNavigationController.swift
//  WordWorld
//
//  Created by 孙海洋 on 05/01/2018.
//  Copyright © 2018 Adam Ltd. All rights reserved.
//

import UIKit

class FirstViewNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func refreshData() {
        let firstViewController = viewControllers.first as! FirstViewController
    //    firstViewController.setupFresh()
       // let offsetT = CGPoint(x: 0, y: -1.0*firstViewController.refreshController.frame.size.height)
 /*       let offsetT = CGPoint(x: 0, y: 100)
        firstViewController.tableView.setContentOffset(offsetT, animated: true)
        firstViewController.refreshController.beginRefreshing()
 */
        firstViewController.refreshController.sendActions(for: .valueChanged)
    }
}
