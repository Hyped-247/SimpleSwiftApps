import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func showMessege(myMessage : String)  {
        let alertController : UIAlertController = UIAlertController(title: "Warning", message: myMessage, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okay)
        present(alertController, animated: true, completion: nil)
        
    }

    @IBAction func cameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            // imagePicker.allowsEditing = false
            present(imagePicker, animated : true,  completion: nil)
        } else {
            showMessege(myMessage: "No camera abailable")
        }
    }
    @IBAction func libraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated : true, completion: nil)
        } else {
            showMessege(myMessage: "No photo library available")
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let myOriginalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        image.image = myOriginalImage
        UIImageWriteToSavedPhotosAlbum(myOriginalImage, nil, nil, nil)
        dismiss(animated: true)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        var stuffToShare : [Any] = []
        let a = image?.image
        let b = text?.text
        
        if a == nil && b == nil {
            showMessege(myMessage : "There is nothing to share")
        }
        if let a = image?.image {
            stuffToShare.append(a)
        }
        if let b = text?.text {
            stuffToShare.append(b)
        }
        let activity = UIActivityViewController(activityItems: stuffToShare,
                                                applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
}



















