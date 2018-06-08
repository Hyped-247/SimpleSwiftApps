import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    func style()  {
        let bgUIcolor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1)
        let myCGColor = bgUIcolor.cgColor
        textView.layer.backgroundColor = myCGColor
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1.0
    }
    @IBAction func viewDidLoad(_ sender: Any) {
        showMesage()
    }

    @IBAction func trash(_ sender: Any) {
        delete()
    }
    
    
    func delete() {
        textView.text = ""
    }
    
    
    func showMesage()   {
        let actionController = UIAlertController(title: "Important maseege", message: "My messege", preferredStyle: .alert)
        let okButtton = UIAlertAction(title: "I get it", style: .default) { (UIAlertAction) in
            self.textView.text = "Ok it did "
        }
        actionController.addAction(okButtton)
        present(actionController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

