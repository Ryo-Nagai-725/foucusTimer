//
//  SaveViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/17.
//

import UIKit
import RealmSwift

class SaveViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var wordTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var categoryTextDoneButton: UIButton!
    @IBOutlet var dataTextDoneButton: UIButton!
    var time = ""
    let realm = try? Realm()
    var pickerIndex: Int = 0
    var categoryList = ["勉強", "仕事", "スポーツ", "娯楽", "休憩", "その他"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = time
        saveButton.layer.cornerRadius = 20
        datePicker.backgroundColor = .white
        setupPickerView()
    }
    
    
    @IBAction func SaveButton(_ sender: Any) {
        addData()
        let userData = realm?.objects(ReportModel.self)
        print("全てのデータ\(userData)")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func shareButton(_ sender: Any) {
        let timeData = realm?.objects(TimerModel.self)
        let text = """
                育てて集中！
                日付：\(dateTextField.text ?? "")
                集中した時間：\(timeLabel.text ?? "")
                カテゴリー：\(categoryTextField.text ?? "")
                ひとこと：\(wordTextField.text ?? "")
                成長した木
                """
                let shareItems = [text] as [Any]
                let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
                present(controller, animated: true, completion: nil)
                
    }
    @IBAction func dataTextDoneButton(_ sender: Any) {
        datePicker.isHidden = true
        dataTextDoneButton.isHidden = true
        dataTextDoneButton.isHidden = true
        // 日付のフォーマット
                let formatter = DateFormatter()

                //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
                formatter.dateFormat = "yyyy/MM/dd"
                dateTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    @IBAction func categoryTextDoneButton(_ sender: Any) {
        categoryPickerView.isHidden = true
        categoryTextDoneButton.isHidden = true
        dataTextDoneButton.isHidden = true
    }
    @IBAction func touchDateText(_ sender: Any) {
        datePicker.isHidden = false
        categoryPickerView.isHidden = true
        dataTextDoneButton.isHidden = false
        dateTextField.resignFirstResponder()
    }
    
    @IBAction func touchCategoryText(_ sender: Any) {
        datePicker.isHidden = true
        categoryPickerView.isHidden = false
        categoryTextDoneButton.isHidden = false
        dataTextDoneButton.isHidden = true
        categoryTextField.resignFirstResponder()
    }
    
    @IBAction func touchWordText(_ sender: Any) {
        datePicker.isHidden = true
        categoryPickerView.isHidden = true
        dataTextDoneButton.isHidden = true
        categoryTextDoneButton.isHidden = true
    }
    
    @IBAction func closeKeyButton(_ sender: Any) {
        wordTextField.resignFirstResponder()
    }
    func addData() {
        let reportModel = ReportModel()
        reportModel.date = dateTextField.text ?? ""
        reportModel.category = categoryTextField.text ?? ""
        reportModel.word = wordTextField.text ?? ""
        try! realm?.write {
            realm?.add(reportModel)
        }
    }
    
    func setupPickerView() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
    }
}

extension SaveViewController: UIPickerViewDelegate {
    // UIPickerViewの最初の表示
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            
            return categoryList[row]
        }
        
        // UIPickerViewのRowが選択された時の挙動
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            pickerIndex = row
            categoryTextField.text = categoryList[row]
            
        }
}

extension SaveViewController: UIPickerViewDataSource {
    // UIPickerViewの列の数
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // UIPickerViewの行数、リストの数
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            return categoryList.count
        }
    
    
}

