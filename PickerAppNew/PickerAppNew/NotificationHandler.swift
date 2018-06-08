import UIKit
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    var application:UIApplication?
    
    func showMessage(message:String) {
        let actionController = UIAlertController(title: "Important Message", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
        }
        
        actionController.addAction(okay)
        
        DispatchQueue.main.async {
            self.application?.keyWindow?.rootViewController?.present(actionController,animated: true, completion: nil)
        }
    }
    
    //Handle foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        showMessage(message: "I'M IN THE FORGROUND")
        application?.applicationIconBadgeNumber = 0
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    
    //Handle background notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //The user dismissed notification without taking action
        if response.actionIdentifier == UNNotificationDismissActionIdentifier {
            showMessage(message: "I have been dismissed")
            application?.applicationIconBadgeNumber = 0
            
        }
        else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            showMessage(message: "I am from the background")
            application?.applicationIconBadgeNumber = 0
            
        }
    }
}
