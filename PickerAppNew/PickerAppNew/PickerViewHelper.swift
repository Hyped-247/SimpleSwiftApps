import UIKit

class PickerViewHelper: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 13
        }
        else {
            return 4
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 {
                return "1"
            }
            else {
                return "\(row * 5)"
            }
        }
        else {
            if row == 0 {
                return "Seconds"
            }
            else if row == 1 {
                return "Minutes"
            }
            else if row == 2 {
                return "Hours"
            }
            else {
                return "Days"
            }
        }
    }
    
    var firstWheel: Int = 0
    var secondWheel: Int = 0
    var answer: Int = 1
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if row == 0 {
                firstWheel = 1
            }
            else {
                firstWheel = 5 * row
            }
        }
        else if component == 1 {
            secondWheel = row
        }
        if secondWheel == 0 {
            answer = firstWheel
        }
        else if secondWheel == 1 {
            answer = firstWheel * 60
        }
        else if secondWheel == 2 {
            answer = firstWheel * 60 * 60
        }
        else if secondWheel == 3 {
            answer = firstWheel * 60 * 60 * 24
        }
        NSLog("\(answer) seconds")
    }
}
