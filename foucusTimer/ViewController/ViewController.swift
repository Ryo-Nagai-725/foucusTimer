//
//  ViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/05/25.
//

import UIKit
import AVFoundation
import RealmSwift
import PanModal

class ViewController: UIViewController {

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var changePageSeg: UISegmentedControl!
    @IBOutlet var monsterImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var growButton: UIButton!
    @IBOutlet var treeBackGroundView: UIView!
    
    var timer: Timer?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        corner()
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
    
    
    @IBAction func startButton(_ sender: Any) {
        startTimer()
        TimerManager.shared.timerManagerDelegate = self
        
    }
    @IBAction func stopButton(_ sender: Any) {
        stopTimer()
    }
    @IBAction func growButton(_ sender: Any) {
        presentPanModal(GrowViewController())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            let SaveView = segue.destination as! SaveViewController
            SaveView.time = timerLabel.text ?? ""
        }
    }
    
    // タイマーメソッド
    func startTimer() {
        TimerManager.shared.startTimer()
        timer = Timer.scheduledTimer(
                   timeInterval: 1,
                   target: self,
                   selector: #selector(self.countTimer),
                   userInfo: nil,
                   repeats: true)
        startButton.isEnabled = false
        growButton.isEnabled = false
        growButton.alpha = 0.5
        startButton.alpha = 0.5
        changePageSeg.alpha = 0
    }
    
    func stopTimer() {
        TimerManager.shared.stopTimer()
        addData()
        let userData = realm.objects(TimerModel.self)
        print("🟥全てのデータ\(userData)")
        timerLabel.text = "00:00:00"
        startButton.alpha = 1
        startButton.isEnabled = true
        growButton.isEnabled = true
        changePageSeg.alpha = 1
        growButton.alpha = 1
        monsterImage.image = UIImage(named: "hutaba")
        
    }
    
    func timeString(time: TimeInterval) -> String {
           let hour = Int(time) / 3600
           let minutes = Int(time) / 60 % 60
           let second = Int(time) % 60
           return String(format: "%02d:%02d:%02d", hour, minutes, second)
    }
    
    
    func addData() {
        let timerModel = TimerModel()
        timerModel.time = timerLabel.text ?? ""
        if monsterImage.image == UIImage(named: "tree3") {
            timerModel.imageUrl = "tree3"
        } else if monsterImage.image == UIImage(named: "tree4") {
            timerModel.imageUrl = "tree4"
        } else if monsterImage.image == UIImage(named: "tree5") {
            timerModel.imageUrl = "tree5"
        } else if monsterImage.image == UIImage(named: "tree6") {
            timerModel.imageUrl = "tree6"
        } else if monsterImage.image == UIImage(named: "tree7") {
            timerModel.imageUrl = "tree7"
        } else if monsterImage.image == UIImage(named: "tree8") {
            timerModel.imageUrl = "tree8"
        } else if monsterImage.image == UIImage(named: "tree9") {
            timerModel.imageUrl = "tree9"
        } else if monsterImage.image == UIImage(named: "tree10") {
            timerModel.imageUrl = "tree10"
        } else if monsterImage.image == UIImage(named: "hutaba") {
            timerModel.imageUrl = "hutaba"
        }
        try! realm.write {
            realm.add(timerModel)
        }
    }
    
    
    func corner() {
        startButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
        growButton.layer.cornerRadius = 10
        treeBackGroundView.layer.cornerRadius = 90
    }
    
    @objc func countTimer() {
        if TimerManager.shared.timerSecond == 10 {
            monsterImage.image = UIImage(named: "tree3")
        } else if (TimerManager.shared.timerSecond == 20) {
            monsterImage.image = UIImage(named: "tree4")
        } else if (TimerManager.shared.timerSecond == 30) {
            monsterImage.image = UIImage(named: "tree5")
        } else if (TimerManager.shared.timerSecond == 40) {
            monsterImage.image = UIImage(named: "tree6")
        } else if (TimerManager.shared.timerSecond == 50) {
            monsterImage.image = UIImage(named: "tree7")
        } else if (TimerManager.shared.timerSecond == 60) {
            monsterImage.image = UIImage(named: "tree8")
        } else if (TimerManager.shared.timerSecond == 70) {
            monsterImage.image = UIImage(named: "tree9")
        } else if (TimerManager.shared.timerSecond == 80){
            monsterImage.image = UIImage(named: "tree10")
        }
    }
}

extension ViewController: TimerManagerDelegate {
    func updateTimer(second: Int) {
        print("updateTimer")
        timerLabel.text = timeString(time: TimeInterval(second))
    }
}
