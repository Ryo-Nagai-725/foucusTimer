//
//  ViewController.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/05/25.
//

import UIKit
import AVFoundation
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var monsterImage: UIImageView!
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
    }


    @IBAction func startButton(_ sender: Any) {
        startTimer()
        
    }
    @IBAction func stopButton(_ sender: Any) {
        stopTimer()
        audioPlayer2?.play()
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
        let path = Bundle.main.path(forResource: "levelUp", ofType: "wav")
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
    }
    
    func stopTimer() {
        timer?.invalidate()
        addData()
        let userData = realm.objects(TimerModel.self)
        print("🟥全てのデータ\(userData)")
        timerSecond = 0
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
    
    @objc func countTimer() {
        timerSecond += 1
        print(timerSecond)
        updateTimer(second: timerSecond)
        if timerSecond == 10 {
            monsterImage.image = UIImage(named: "images")
            audioPlayer?.play()
        } else if timerSecond == 20 {
            monsterImage.image = UIImage(named: "froo")
            audioPlayer?.play()
        } else if timerSecond == 30 {
            monsterImage.image = UIImage(named: "unnamed")
            audioPlayer?.play()
        } else if timerSecond == 40 {
            monsterImage.image = UIImage(named: "C6WogxtUwAAEZc-")
            audioPlayer?.play()
        } else if timerSecond == 50 {
            monsterImage.image = UIImage(named: "slime")
            audioPlayer?.play()
        }
    }
    
}
