//
//  SceneDelegate.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/05/25.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    // アプリ画面に復帰した時
    internal func sceneDidBecomeActive(_ scene: UIScene) {
        print("*************************************")
        print("アプリ画面に復帰した時")
        print("*************************************")
        TimerManager.shared.updateTimerDidBecomeActive()
    }
    
    // アプリ画面から離れる時（ホームボタン押下、スリープ）
    func sceneWillResignActive(_ scene: UIScene) {
        print("*************************************")
        print("アプリ画面から離れる時")
        print("*************************************")
        TimerManager.shared.saveDateTime()
        let content = UNMutableNotificationContent()
              content.title = "逃げないでください✋"
              content.body = "通知をタップしてアプリに戻りましょう！"
              content.sound = UNNotificationSound.default

              // 直ぐに通知を表示
              let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
              UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
          }
        
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
