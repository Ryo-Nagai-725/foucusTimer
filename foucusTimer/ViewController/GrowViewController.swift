//
//  GrowViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/20.
//

import UIKit
import PanModal

class GrowViewController: UIViewController, UITableViewDelegate {
    
    var tableView = UITableView()
    var items = ["トマト", "キュウリ", "ブロッコリー", "レタス", "キャベツ", "ズッキーニ"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view.addSubview(tableView)
    }
}


extension GrowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

extension GrowViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
