//
//  AddTodoViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/07/20.
//

import UIKit
import RealmSwift

class AddTodoViewController: UIViewController  {

  
    @IBOutlet var titleTextFiled: UITextField!
    @IBOutlet var memoTextFiled: UITextView!
    @IBOutlet var startTimeTextFiled: UITextField!
    @IBOutlet var endTimeTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    
}
