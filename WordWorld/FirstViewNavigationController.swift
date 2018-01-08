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
        firstViewController.pullRefresh()
    }
}
