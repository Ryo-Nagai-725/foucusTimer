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
    @IBOutlet var monsterImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var growButton: UIButton!
    @IBOutlet var treeBackGroundView: UIView!
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    let path = Bundle.main.path(forResource: "nc205000", ofType: "mp3")
    var timer: Timer?
    var timerSecond = 0
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        levelUpMusic()
        endMusic()
        corner()
    }


    @IBAction func startButton(_ sender: Any) {
        startTimer()
        
    }
    @IBAction func stopButton(_ sender: Any) {
        stopTimer()
        audioPlayer2?.play()
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
    
    //ミュージックメソッド
    func levelUpMusic() {
        //プロジェクト内ににあるパスを参照
        let path = Bundle.main.path(forResource: "growthSound", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        try! audioPlayer = AVAudioPlayer(contentsOf: url)
        //事前に一度再生をしておかないとず正しく再生されないことがあるのでこいつを呼び出しておく
         audioPlayer?.prepareToPlay()
    }
    
    func endMusic() {
        //プロジェクト内ににあるパスを参照
        let path = Bundle.main.path(forResource: "end", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        try! audioPlayer2 = AVAudioPlayer(contentsOf: url)
        //事前に一度再生をしておかないとず正しく再生されないことがあるのでこいつを呼び出しておく
         audioPlayer2?.prepareToPlay()
    }
    // タイマーメソッド
    func startTimer() {
        timer?.invalidate()
        timerSecond = 0
        timer = Timer.scheduledTimer(
                   timeInterval: 1,
                   target: self,
                   selector: #selector(self.countTimer),
                   userInfo: nil,
                   repeats: true)
        startButton.isEnabled = false
        startButton.alpha = 0.5
    }
    
    func stopTimer() {
        timer?.invalidate()
        addData()
        let userData = realm.objects(TimerModel.self)
        print("🟥全てのデータ\(userData)")
        timerLabel.text = "00:00:00"
        startButton.alpha = 1
        startButton.isEnabled = true
    }
    
    func timeString(time: TimeInterval) -> String {
           let hour = Int(time) / 3600
           let minutes = Int(time) / 60 % 60
           let second = Int(time) % 60
           return String(format: "%02d:%02d:%02d", hour, minutes, second)
    }
    
    func updateTimer(second: Int) {
            print("updateTimer")
            timerLabel.text = timeString(time: TimeInterval(second))
        }
    
    func addData() {
        let timerModel = TimerModel()
        timerModel.time = timerLabel.text ?? ""
        try! realm.write {
            realm.add(timerModel)
        }
    }
    
    func corner() {
        startButton.layer.cornerRadius = 50
        stopButton.layer.cornerRadius = 50
        growButton.layer.cornerRadius = 50
        treeBackGroundView.layer.cornerRadius = 20
    }
    
    @objc func countTimer() {
        timerSecond += 1
        print(timerSecond)
        updateTimer(second: timerSecond)
        if timerSecond == 10 {
            monsterImage.image = UIImage(named: "tree3")
            audioPlayer?.play()
        } else if timerSecond == 20 {
            monsterImage.image = UIImage(named: "tree4")
            audioPlayer?.play()
        } else if timerSecond == 30 {
            monsterImage.image = UIImage(named: "tree5")
            audioPlayer?.play()
        } else if timerSecond == 40 {
            monsterImage.image = UIImage(named: "tree6")
            audioPlayer?.play()
        } else if timerSecond == 50 {
            monsterImage.image = UIImage(named: "tree7")
            audioPlayer?.play()
        } else if timerSecond == 60 {
            monsterImage.image = UIImage(named: "tree8")
            audioPlayer?.play()
        } else if timerSecond == 70 {
            monsterImage.image = UIImage(named: "tree9")
            audioPlayer?.play()
        } else if timerSecond == 80 {
            monsterImage.image = UIImage(named: "tree10")
            audioPlayer?.play()
        }
    }
    
}
