//
//  WordDetailViewController.swift
//  WordWorld
//
//  Created by 孙海洋 on 30/11/2017.
//  Copyright © 2017 Adam Ltd. All rights reserved.
//

import UIKit

class WordDetailViewController: UIViewController {
    @IBOutlet weak var wordDetail: UILabel!
    @IBOutlet weak var examplesentence: UITextView!

    var wordInfo: Word?

    override func viewDidLoad() {
        super.viewDidLoad()
    //    wordInfo = delegate.passWordInfo(wordInfo: <#T##Word#>)
        wordDetail.text = wordInfo?.chineseWord
        examplesentence.text = wordInfo?.sentence
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
