//
//  FirstViewController.swift
//  WordWorld
//
//  Created by 孙海洋 on 2017/10/11.
//  Copyright © 2017年 Adam Ltd. All rights reserved.
//

import UIKit
import SQLite

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var wordsDict = [(String, Word)]()

    let name_links_tuples : [(String,String)] =
        [
            ("四川麻将iphone","https://itunes.apple.com/cn/app/bo-ya-si-chuan-ma-jiang/id510582247?mt=8"),
            ("四川麻将ipad","https://itunes.apple.com/cn/app/bo-ya-si-chuan-ma-jianghd/id551932207?mt=8"),
            ("二人麻将iphone","https://itunes.apple.com/cn/app/bo-ya-er-ren-ma-jiang/id687598024?l=en&mt=8"),
            ("二人麻将ipad","https://itunes.apple.com/cn/app/bo-ya-er-ren-ma-jianghd/id768019415?l=en&mt=8"),
        ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsDict.count
      //  return name_links_tuples.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)

 //       let title :String = wordsDict[indexPath.row].0
        let title :String = wordsDict[indexPath.row].0
        cell.textLabel!.text = title
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
//            let fileManager = FileManager.default
//            let dbPath = fileManager.currentDirectoryPath
            let fileManager = FileManager.default
            let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as! String
            let destPath = docPath + "/words.db"
            let sourceDbPath = Bundle.main.path(forResource: "words", ofType: "db")

            do {
                try fileManager.copyItem(atPath: sourceDbPath!, toPath: destPath)
            }
            catch  {
                print("failed")
            }

        //    let db = try Connection("/Users/sunhaiyang/Documents/GitRepo/iosTest/WordWorld/WordWorld/words.db")
            let db = try Connection(destPath)

            let word = Word()
            let wordList = Table("CET4WORDSTEST1")
            let id = Expression<Int64>("Id")
            let english = Expression<String>("English")
            let chinese = Expression<String>("Chinese")
            let level = Expression<Int64>("Level")

            for wordRow in try db.prepare(wordList) {
//                print("english: \(wordRow[english]), chinese: \(wordRow[chinese]), level: \(wordRow[level])")
            word.id = wordRow[id]
            word.engWord = wordRow[english]
            word.chineseWord = wordRow[chinese]
            word.level = wordRow[level]
            wordsDict.append((word.engWord, word))
                print("english: \(word.engWord), chinese: \(word.chineseWord), level: \(word.level)")
            }
            tableView.dataSource = self
            tableView.delegate = self
     //       self.view.addSubview(tableView)
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

