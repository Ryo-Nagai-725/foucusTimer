//
//  TimerManager.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/01.
//

import Foundation

protocol TimerManagerDelegate: AnyObject {
    func updateTimer(second: Int)
}

class TimerManager {
    static let shared = TimerManager()
    static let startTimerKey = "startTimer"
    
    var timer: Timer?
    var timerSecond = 0
    
    weak var timerManagerDelegate: TimerManagerDelegate?
}

internal extension TimerManager {
    // 計測開始
    func startTimer() {
        timer?.invalidate()
        timerSecond = 0
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // 計測終了
    func stopTimer() {
        timer?.invalidate()
    }
    
    // リセット
    func resetTimer() {
        timerSecond = 0
    }
    
    // アプリがバックグラウンドから復帰したときにカウントを更新
    func updateTimerDidBecomeActive() {
        guard let diff = TimerManager.shared.getDiffSeconds() else { return }
        print("************************")
        print("diff = \(diff)")
        if timer?.isValid ?? true {
            TimerManager.shared.append(second: diff)
            print("timerSecond = \(timerSecond)")
            print("************************")
            timerManagerDelegate?.updateTimer(second: timerSecond)
        }
    }
    
    // アプリから離れる時に時間を保持しておく
    func saveDateTime() {
        UserDefaults.standard.set(Date(), forKey: TimerManager.startTimerKey)
    }
}

private extension TimerManager {
    @objc func updateTimer() {
        print("a")
        timerSecond += 1
        print(timerSecond)
        timerManagerDelegate?.updateTimer(second: timerSecond)
    }
    
    // バックグラウンドから来た時に、時間を計算する
    func append(second: Int) {
        timerSecond += second
        // 再びタイマーを起動
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // アプリから離れる時の時間を取得する
    func getSavedDateTime() -> Date? {
        return UserDefaults.standard.value(forKey: TimerManager.startTimerKey) as? Date
    }
    
    // 差分の時間を取得
    func getDiffSeconds() -> Int? {
        guard let startTimer = TimerManager.shared.getSavedDateTime() else { return nil }
        let calendar = Calendar(identifier: .gregorian)
        let currentTime = Date()
        let elapsedTime = calendar.dateComponents([.second], from: startTimer, to: currentTime).second
        return elapsedTime
    }
}
