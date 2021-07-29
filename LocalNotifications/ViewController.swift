//
//  ViewController.swift
//  LocalNotifications
//
//  Created by 大西玲音 on 2021/07/30.
//

import UIKit
import UserNotifications
import AudioToolbox

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction private func notificationButtonDidTapped(_ sender: Any) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("通知許可されている")
            } else {
                //　許可を拒否した場合(grantedがfalse)は将来有効にするには設定画面に移動し、有効にする必要があることをユーザーに伝える。
                print("通知拒否されている")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "タイトル"
        content.subtitle = "サブタイトル"
        content.body = "ボディー"
        content.sound = .default
        
        let date = Date().addingTimeInterval(2)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: false)
        let request = UNNotificationRequest(identifier: "テストID",
                                            content: content,
                                            trigger: trigger)
        
        center.delegate = self
        center.add(request) { error in
            print("requestが送られた")
        }
    }
    
    
}

extension ViewController: UNUserNotificationCenterDelegate {
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("通知をタップしてアプリが起動された")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("フォアグラウンドの時に通知が来たら呼ばれる")
        completionHandler([.banner, .sound])
        
    }
    
}
