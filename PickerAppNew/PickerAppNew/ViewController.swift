import UIKit
import UserNotifications
import os.log

class ViewController: UIViewController {
    
    var pickerViewHelper: PickerViewHelper?
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewHelper = PickerViewHelper()
        picker.delegate = pickerViewHelper
        picker.dataSource = pickerViewHelper
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestPermission(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {(granted,error) in
            if (!granted) {
                os_log("I am not trusted")
            }
        })
    }
    
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "ALARM"
        content.body = "I am your alarm"
        content.sound = UNNotificationSound.default()
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        guard let helper = self.pickerViewHelper else {return}
        let time = Double(helper.answer)
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: time, repeats: false)
        
        let request = UNNotificationRequest.init(identifier: "MyAlarm", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request)
    }
    
    @IBAction func button(_ sender: Any) {
        requestPermission()
        createNotification()
    }
    
    
}
