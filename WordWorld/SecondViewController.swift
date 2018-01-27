//
//  SecondViewController.swift
//  WordWorld
//
//  Created by 孙海洋 on 2017/10/11.
//  Copyright © 2017年 Adam Ltd. All rights reserved.
//

import UIKit
import SQLite

class SecondViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var engTextfield: UITextField!
    @IBOutlet weak var mandTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sentence: UITextView!
    
    let wordCategory = ["CET4", "CET6", "MASTER"]
    let repeatInterval = ["One Week", "Two Ween", "Three Wee"]
    let difficultyLeve = ["Easy", "Normal", "Hard"]
    var dbConnection: Connection!

    @IBAction func saveClick(_ sender: UIButton) {
        let engWord = engTextfield.text?.trimmingCharacters(in: .whitespaces)
        let mandWord = mandTextfield.text?.trimmingCharacters(in: .whitespaces)
        let categoryIndex = pickerView.selectedRow(inComponent: 0)
        let intervalIndex = pickerView.selectedRow(inComponent: 1)
        let levelIndex = pickerView.selectedRow(inComponent: 2)
        let strCategory = wordCategory[categoryIndex]
        let strInterval = repeatInterval[intervalIndex]
        let strLevel = difficultyLeve[levelIndex]
        let strSentence = sentence.text
        saveToDB(engWord: engWord!, mandWord: mandWord!, category: strCategory,
                 interval: intervalIndex, sentence: strSentence!)
    }

    func saveToDB(engWord: String, mandWord: String, category: String,
                  interval: Int, sentence: String){
        let wordList = Table("MasterWords")
        let id = Expression<Int64>("id")
        let english = Expression<String>("english")
        let chinese = Expression<String>("mandarin")
        let clause = Expression<String>("clause")
        let reciteTimes = Expression<Int64>("reciteTimes")
        let difficulty = Expression<Int64>("difficulty")
        let createDate = Expression<Date>("createDate")
//        let picture = Expression<Blob>("picture")

        let insertWord = wordList.filter(english == engWord)
        do {
            try dbConnection.run(insertWord.delete())
        } catch {
            print(error)
        }

        //temp for db save
        let tmpReciteTimes = 1
        let tmpCreateDate = Date(timeIntervalSince1970: 0)
        let insert = wordList.insert(id <- 2, english <- engWord, chinese <- mandWord, clause <- sentence, reciteTimes <- Int64(tmpReciteTimes), createDate <- tmpCreateDate, difficulty <- 4)
        do {
            let rowid = try dbConnection.run(insert)
            print(rowid)
        } catch {
            print(error)
        }
    }

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

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let destPath = appDelegate.dbPath! as String
        do {
            dbConnection = try Connection(destPath)
        } catch {
            print(error)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        engTextfield.resignFirstResponder()
        mandTextfield.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }


}

