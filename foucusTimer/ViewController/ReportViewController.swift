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
    @IBOutlet var reportTableView: UITableView!
    
    let realm = try! Realm()
    let months = ["勉強", "仕事", "趣味", "娯楽", "読書", "その他"]
        let unitsSold = [40.0, 10.0, 16.0, 13.0, 12.0, 16.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setPieChart()
    }
    
    func setTableView() {
        reportTableView.dataSource = self
        reportTableView.delegate = self
        reportTableView.layer.cornerRadius = 20.0
        reportTableView.register(UINib(nibName: ReportTableViewCell.className, bundle: nil), forCellReuseIdentifier: ReportTableViewCell.className)
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

extension ReportViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reportTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.className, for: indexPath) as? ReportTableViewCell else {
                        return UITableViewCell()
                    }
        let timeData = realm.objects(TimerModel.self)
        reportTableViewCell.timeLabel.text = "\(timeData[indexPath.row].time)"
        let userData = realm.objects(ReportModel.self)
        reportTableViewCell.dateLabel.text = "\(userData[indexPath.row].date)"
        reportTableViewCell.categoryLabel.text = "\(userData[indexPath.row].category)"
        reportTableViewCell.wordLabel.text = "\(userData[indexPath.row].word)"
        reportTableViewCell.selectionStyle = .none
                    return reportTableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension ReportViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userData = realm.objects(ReportModel.self)
        return userData.count
    }
}
