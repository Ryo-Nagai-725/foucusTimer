//
//  TimeLineViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/08/09.
//

import UIKit
import RealmSwift
class TimeLineViewController: UIViewController {

    @IBOutlet var timeLineTableView: UITableView!
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    

    func setTableView() {
        timeLineTableView.dataSource = self
        timeLineTableView.delegate = self
        timeLineTableView.layer.cornerRadius = 20.0
        timeLineTableView.register(UINib(nibName: ReportTableViewCell.className, bundle: nil), forCellReuseIdentifier: ReportTableViewCell.className)
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
}

extension TimeLineViewController: UITableViewDelegate {
    
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
        return 120
    }
}

extension TimeLineViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userData = realm.objects(ReportModel.self)
        return userData.count
    }
}

