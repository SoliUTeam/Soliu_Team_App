////
////  NotificationViewController.swift
////  Soliu
////
////  Created by Yoonha Kim on 6/20/21.
////
//
//import UIKit
//
//class NotificationViewController: UIViewController {
//
//    @IBOutlet private weak var timerTextView: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        UNUserNotificationCenter.current().delegate = self
//    }
//
//    // Notification Repeat Action
//    @IBAction private func notificationWithDifferentAction() {
//
//        let notificationID = "Soliu"
//        let notificationContent = UNMutableNotificationContent()
//        notificationContent.title = "Please write your diary"
//        notificationContent.subtitle = "Don't forget your update diary"
//        notificationContent.badge = 1
//
//        // Sounds
//        notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName.init("notification.wav"))
//
//        // Notification Attachment, in many different way
//        guard let url = Bundle.main.url(forResource: "logo", withExtension: "png") else { return }
//        do {
//        try notificationContent.attachments = [UNNotificationAttachment.init(identifier: "image", url: url, options: nil)]
//        }
//        catch {
//            print("can't find picture")
//        }
//
//        // Add, Action into notification
//        let repeatAction = UNNotificationAction(identifier: "repeat", title: "Repeat", options: [])
//        let changeAction = UNTextInputNotificationAction(identifier: "change", title: "Change", options: [])
//
//        // Category list in notification
//        let category = UNNotificationCategory(identifier: "actionCategory", actions: [repeatAction, changeAction], intentIdentifiers: [], options: [.hiddenPreviewsShowSubtitle])
//        notificationContent.categoryIdentifier = "actionCategory"
//
//        let timeInterval = Double(timerTextView.text ?? "") ?? 0.0
//        print("timeSet: \(timeInterval)")
//        // UNotificationRequest Current
//        let timeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
//        let request = UNNotificationRequest(identifier: notificationID, content: notificationContent, trigger: timeIntervalNotificationTrigger)
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error : \(error)")
//            } else {
//                print("Schedule notification")
//            }
//        }
//    }
//
//}
//extension NotificationViewController: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        switch response.actionIdentifier {
//        case "repeat":
//            print("repeat")
//        case "change":
//            print("change")
//
//        default:
//            break;
//        }
//    }
//
//}
