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
    @IBOutlet var barChartView: BarChartView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var focusCountLabel: UILabel!
    let realm = try! Realm()
    let months = ["勉強", "仕事", "趣味", "娯楽", "読書", "その他"]
    let unitsSold = [40.0, 10.0, 16.0, 13.0, 12.0, 16.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        setPieChart()
        setBurChart()
        let results = realm.objects(ReportModel.self)
        focusCountLabel.text = "\(results.count)個"
        
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
    
    func setBurChart() {
        let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.drawValuesEnabled = false
        dataSet.colors = [.systemBlue]
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        // X軸のラベルの位置を下に設定
        barChartView.xAxis.labelPosition = .bottom
        // X軸のラベルの色を設定
        barChartView.xAxis.labelTextColor = .systemGray
        // X軸の線、グリッドを非表示にする
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        // 右側のY座標軸は非表示にする
        barChartView.rightAxis.enabled = false
        // Y座標の値が0始まりになるように設定
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.drawZeroLineEnabled = true
        barChartView.leftAxis.zeroLineColor = .systemGray
        // ラベルの数を設定
        barChartView.leftAxis.labelCount = 5
        // ラベルの色を設定
        barChartView.leftAxis.labelTextColor = .systemGray
        // グリッドの色を設定
        barChartView.leftAxis.gridColor = .systemGray
        // 軸線は非表示にする
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.legend.enabled = false
        let avg = rawData.reduce(0) { return $0 + $1 } / rawData.count
        let limitLine = ChartLimitLine(limit: Double(avg))
        limitLine.lineColor = .systemOrange
        limitLine.lineDashLengths = [4]
        barChartView.leftAxis.addLimitLine(limitLine)
    }
}


