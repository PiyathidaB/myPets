import UIKit
import UserNotifications

class AddPet: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet var addName:UITextField!
    @IBOutlet weak var addType: UITextField!
    @IBOutlet weak var addBirthday: UITextField!
    @IBOutlet var addAge: UITextField!
    @IBOutlet var addWeight: UITextField!
    @IBOutlet var addFavorite: UITextField!
    @IBOutlet weak var addImage: UIImageView!
    
    
    var typePickerView: UIPickerView!
    var pickerType = ["Dog","Cat","Rat","Rabbit","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    //set typePickerView
    
    
    @IBAction func showType(_ sender: UITextField) {
        typePickerView = UIPickerView()
        sender.inputView = typePickerView
        
        typePickerView.delegate = self
        
        addType.inputView = typePickerView
    }
     
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return addType.text = pickerType[row]
    }
    
  
    //set dataPicket
    var datePickerView: UIDatePicker!
    
    @IBAction func showDatePicker(_ sender: UITextField) {
        datePickerView = UIDatePicker()
        sender.inputView = datePickerView
        
        let toolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = UIBarStyle.default
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        sender.inputAccessoryView = toolBar
        
    }
    
    @objc func doneTapped(sender: UIBarButtonItem!){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        addBirthday.text = dateFormatter.string(from: datePickerView.date)
        addBirthday.resignFirstResponder()
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        addBirthday.resignFirstResponder()
    }
    
    //pick image
    
    let imagePick = UIImagePickerController()
    
    ////add pic form camera
    
    @IBAction func photoLibrary(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePick = UIImagePickerController()
            imagePick.delegate = self
            imagePick.sourceType = .photoLibrary
            imagePick.allowsEditing = true
            imagePick.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(imagePick, animated: true, completion: nil)
            
        }
    }
    
    //get path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let doucumetsDirectory = paths[0]
        return doucumetsDirectory
    }
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chooseImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        addImage.image = chooseImage
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //add
    
    
    @IBAction func addNewRow() {
        let id = Database.addPet(name: addName.text! ,type: addType.text! ,birthday: addBirthday.text! ,age: Int(addAge.text!)! ,weight: Int(addWeight.text!)! ,favorite: addFavorite.text!  )
        
        
        if let data = UIImageJPEGRepresentation(addImage.image!, 1.0){
            let imagePath = getDocumentsDirectory().appendingPathComponent("image\(id).jpg")
            try! data.write(to: imagePath)
        }
        
        navigationController?.popViewController(animated:true)
    }
    
}


