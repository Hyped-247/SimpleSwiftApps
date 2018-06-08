import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var pmwCon: NSLayoutConstraint!
    @IBOutlet weak var pmsCon: NSLayoutConstraint!
    @IBOutlet weak var pmeCon: NSLayoutConstraint!
    @IBOutlet weak var pmnCon: NSLayoutConstraint!
    @IBOutlet weak var pMapHeight: NSLayoutConstraint!
    @IBOutlet weak var pViewEast: NSLayoutConstraint!
    @IBOutlet weak var pViewWest: NSLayoutConstraint!
    @IBOutlet weak var pViewSouth: NSLayoutConstraint!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func HideButton(_ sender: Any) {
        if button.currentTitle == "Hide" {
            button.setTitle("Show", for: .normal)
            view.isHidden = true
            
        }else {
            button.setTitle("Hide", for: .normal)
        }
    }
}






















