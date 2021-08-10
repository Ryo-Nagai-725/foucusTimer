//
//  ReportViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/08.
//
import UIKit
import Charts
import RealmSwift
class ReportViewController: UIViewController {
    
    @IBOutlet var PieChartView: PieChartView!
    @IBOutlet var backgroundView: UIView!
    
    let realm = try! Realm()
    let months = ["勉強", "仕事", "趣味", "娯楽", "読書", "その他"]
        let unitsSold = [40.0, 10.0, 16.0, 13.0, 12.0, 16.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        setPieChart()
        self.view.sendSubviewToBack(backgroundView)
    }
    
    @IBAction func changeViewPage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                // Firstをタップされた時に実行される処理
                self.performSegue(withIdentifier: "toFirst", sender: nil)
            case 1:
                // Secondをタップされた時に実行される処理
                self.performSegue(withIdentifier: "toSecond", sender: nil)
            case 2:
                // Thirdをタップされた時に実行される処理
                self.performSegue(withIdentifier: "toThird", sender: nil)
            default:
                print("")
            }
    }
    
    
    func setPieChart(){
            
            var dataEntries: [ChartDataEntry] = []
     
            for i in 0..<months.count {
                dataEntries.append( PieChartDataEntry(value: unitsSold[i], label: months[i], data: unitsSold[i]))
            }
     
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "カテゴリ")
     
            PieChartView.data = PieChartData(dataSet: pieChartDataSet)
     
            var colors: [UIColor] = []
     
            for _ in 0..<months.count {
                let red = Double(arc4random_uniform(256))
                let green = Double(arc4random_uniform(256))
                let blue = Double(arc4random_uniform(256))
     
                let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
                colors.append(color)
            }
     
            pieChartDataSet.colors = colors
        }
}
