//
//  DBProvider.swift
//  WordWorld
//
//  Created by 孙海洋 on 12/02/2018.
//  Copyright © 2018 Adam Ltd. All rights reserved.
//

import Foundation
import SQLite

class DBProvider: NSObject{
    var dbPath: String?
    var db: Connection?
    var selectedWord: Word?
    var wordList:Table?
    
    override init() {
        let fileManager = FileManager.default
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        let destPath = docPath + "/words.db"
        let sourceDbPath = Bundle.main.path(forResource: "words", ofType: "db")
        dbPath = destPath
        do {
            try fileManager.copyItem(atPath: sourceDbPath!, toPath: destPath)
        }
        catch  {
            print("failed")
        }
    }
    
    func getWordsArray() -> [(String, Word)]{
        var wordsArray = [(String, Word)]()
        do {
            wordsArray.removeAll()
            let destPath = dbPath! as String
            db = try Connection(destPath)
            wordList = Table("WORDSPOOL")
            let id = Expression<Int64>("Id")
            let english = Expression<String>("English")
            let chinese = Expression<String>("Mandarin")
            let level = Expression<Int64>("Difficulty")
            let sentence = Expression<String>("Clause")
            
            for wordRow in (try db?.prepare(wordList!))! {
                let word = Word()
                word.id = wordRow[id]
                word.engWord = wordRow[english]
                word.chineseWord = wordRow[chinese]
                word.level = wordRow[level]
                word.sentence = wordRow[sentence]
                wordsArray.append((word.engWord, word))
                print("english: \(word.engWord), chinese: \(word.chineseWord), level: \(word.level)")
            }
        } catch {
            print(error)
        }
        return wordsArray
    }
}
