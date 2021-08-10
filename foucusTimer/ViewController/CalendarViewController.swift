//
//  CalendarViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/07/20.
//

import UIKit
import RealmSwift
import FSCalendar
class CalendarViewController: UIViewController,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UIGestureRecognizerDelegate {

    @IBOutlet var calendarView: UIView!
    @IBOutlet var dateTableView: UITableView!
    @IBOutlet var tapDateLabel: UILabel!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        corner()
        
    }
    
    func setTableView() {
        dateTableView.dataSource = self
        dateTableView.delegate = self
        dateTableView.register(UINib(nibName: CalendarTableViewCell.className, bundle: nil), forCellReuseIdentifier: CalendarTableViewCell.className)
        }
    
    

    func corner() {
        calendarView.layer.cornerRadius = 10
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        tapDateLabel.text = "\(year)/\(month)/\(day)"
    }
}
    

extension CalendarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let calendarTableViewCell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.className, for: indexPath) as? CalendarTableViewCell else {
                        return UITableViewCell()
                    }
        return calendarTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todoData = realm.objects(EventModel.self)
        return todoData.count
    }
}


