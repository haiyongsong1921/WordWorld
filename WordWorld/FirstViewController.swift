//
//  FirstViewController.swift
//  WordWorld
//
//  Created by 孙海洋 on 2017/10/11.
//  Copyright © 2017年 Adam Ltd. All rights reserved.
//

import UIKit
import SQLite

class FirstViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var wordsArray = [(String, Word)]()//Dictionary<String, Word>()//[(String, Word)]()
    var wordsArrayForSearch = [(String, Word)]()
    var refreshController: UIRefreshControl!
    var detailViewController = WordDetailViewController()
    var selectedWord: Word?
    var wordList:Table?
    var db: Connection?

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let buttonItem = item.tag
        print(buttonItem)
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let ints=23
        print(ints)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let tempWordsArray = wordsArray
        if searchText == "" {
            wordsArray = wordsArrayForSearch
        } else {
            wordsArray = []
            for word in tempWordsArray {
                if word.0.lowercased().hasPrefix(searchText.lowercased()) {
                    wordsArray.append(word)
                }
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        wordsArray = wordsArrayForSearch
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
      //  return name_links_tuples.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        let title :String = wordsArray[indexPath.row].0
       // var unkonw = wordsArray[indexPath.row].popFirst()?.key
        cell.textLabel!.text = title
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let engWord = wordsDict[indexPath.row].0
        let wordInfo = wordsArray[indexPath.row].1
     //   let detailViewController = WordDetailViewController()
    //    navigationController?.pushViewController(detailViewController, animated: true)
        selectedWord = wordInfo
        performSegue(withIdentifier: "segue", sender: self)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            let removeWord = wordsArray.remove(at: indexPath.row)
            deleteDataFromDB(wordDeleteId: removeWord.1.id)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataFromBD()

        tableView.dataSource = self
        tableView.delegate = self

        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = true

        self.setupFreshControl()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func setupFreshControl(){
        refreshController = UIRefreshControl()
        refreshController.attributedTitle = NSAttributedString(string: "refresh new words")
        tableView.addSubview(refreshController)
        refreshController?.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
    }
    @objc func pullRefresh() {
        loadDataFromBD()
        refreshController?.endRefreshing()
        tableView.reloadData()
    }

    func loadDataFromBD() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dbProvider = appDelegate.dbProvider! as DBProvider
        
        wordsArray = dbProvider.getWordsArray()
        wordsArrayForSearch = wordsArray
    }

    func deleteDataFromDB(wordDeleteId: Int64) {
    //    let english = Expression<String>("English")
        let id = Expression<Int64>("Id")
        let removeWord = wordList?.filter(id == wordDeleteId)
        do {
            try db!.run(removeWord!.delete())
        } catch {
            print(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let detailViewController = segue.destination as! WordDetailViewController
            detailViewController.wordInfo = selectedWord
        }
    }
}

