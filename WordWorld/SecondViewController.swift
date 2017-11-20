//
//  SecondViewController.swift
//  WordWorld
//
//  Created by 孙海洋 on 2017/10/11.
//  Copyright © 2017年 Adam Ltd. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    let wordCategory = ["CET4", "CET6", "考研"]
    let repeatInterval = ["One Week", "Two Ween", "Three Wee"]
    let difficultyLeve = ["Easy", "Normal", "Hard"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch component {
        case 0:
            return wordCategory.count
        case 1:
            return repeatInterval.count
        case 2:
            return difficultyLeve.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            let category = wordCategory[row]
            return category
        case 1:
            return repeatInterval[row]
        case 2:
            return difficultyLeve[row]
        default:
            return ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.backgroundColor = UIColor.yellow
        pickerView.dataSource = self
        pickerView.delegate  = self
        pickerView.selectRow(1, inComponent: 0, animated: true)
        pickerView.selectRow(2, inComponent: 1, animated: true)
        pickerView.selectRow(3, inComponent: 2, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

