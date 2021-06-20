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
    
    let categoryPickerView = UIPickerView()
    var pickerIndex: Int = 0
    var time = ""
    let realm = try? Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = time
        setupCategoryPickerView()
    }
    
    
    @IBAction func SaveButton(_ sender: Any) {
        addData()
        dismiss(animated: true, completion: nil)
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
    //    ピッカービューメソッド
       
       func setupDatePickerView() {
        DatePickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: DatePickerView.bounds.size.height)
           let DatePV = UIView(frame: DatePickerView.bounds)
        DatePV.backgroundColor = UIColor.white
        DatePV.addSubview(DatePickerView)
           
           // UITextField編集時に表示されるキーボードをpickerViewに置き換える
           dateTextField.inputView = DatePV
       }
       
       func setupCategoryPickerView() {
           categoryPickerView.delegate = self
           categoryPickerView.dataSource = self
           categoryPickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: categoryPickerView.bounds.size.height)
           let categoryPV = UIView(frame: categoryPickerView.bounds)
           categoryPV.backgroundColor = UIColor.white
           categoryPV.addSubview(categoryPickerView)
           categoryPickerView.selectRow(0, inComponent: 0, animated: true)
           
           // UITextField編集時に表示されるキーボードをpickerViewに置き換える
           categoryTextField.inputView = categoryPV
       }
  

}
extension SaveViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            categoryTextField.text = CategoryList.shared.category[row]
            pickerIndex = row
        }
    }

extension SaveViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return CategoryList.shared.category.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return CategoryList.shared.category[row]
        }

extension SaveViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            categoryTextField.text = CategoryList.shared.category[pickerIndex]
        
        return true
    }
}
