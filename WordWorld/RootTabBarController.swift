//
//  RootTabBarController.swift
//  WordWorld
//
//  Created by 孙海洋 on 05/01/2018.
//  Copyright © 2018 Adam Ltd. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let firstViewNavigationController = viewController as? FirstViewNavigationController {
            firstViewNavigationController.refreshData()
        } else if viewController is SecondViewController {
            print("Second View")
        }
    }
}
