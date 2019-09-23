import UIKit

class EditViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var typeLabel: UITextField!
    @IBOutlet var birthdayLabel: UITextField!
    @IBOutlet var ageLabel: UITextField!
    @IBOutlet var weightLabel: UITextField!
    @IBOutlet var favoriteLabel: UITextField!
    @IBOutlet weak var imageSelect: UIImageView!
    
    var pet: Pet?
    var petID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pet = pet {
            petID = pet.id
            nameLabel.text = pet.name
            typeLabel.text = pet.type
            birthdayLabel.text = pet.birthday
            ageLabel.text = "\(pet.age)"
            weightLabel.text = "\(pet.weight)"
            favoriteLabel.text = pet.favorite
            getImage(pet: pet)
        }
        
    }
    //type
    var typePickerView: UIPickerView!
    var pickerType = ["Dog","Cat","Rat","Rabbit","Other"]
    
    @IBAction func shoeType(_ sender: UITextField) {
        typePickerView = UIPickerView()
        sender.inputView = typePickerView
        
        typePickerView.delegate = self
        
        typeLabel.inputView = typePickerView
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
        return typeLabel.text = pickerType[row]
    }
    
    
    //date
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
        
        birthdayLabel.text = dateFormatter.string(from: datePickerView.date)
        birthdayLabel.resignFirstResponder()
    }
    
    @objc func cancelTapped(sender:UIBarButtonItem!) {
        birthdayLabel.resignFirstResponder()
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
        imageSelect.image = chooseImage
        
        
        dismiss(animated: true, completion: nil)
    }
    
    //edit
    
    
    @IBAction func editPet() {
        Database.updatePet(id: petID, name: nameLabel.text!, type: typeLabel.text!, birthday: birthdayLabel.text!, age: Int(ageLabel.text!)!, weight: Int(weightLabel.text!)!, favorite: favoriteLabel.text!)
        
        if let data = UIImageJPEGRepresentation(imageSelect.image!, 1.0){
            let imagePath = getDocumentsDirectory().appendingPathComponent("image\(petID).jpg")
            try! data.write(to: imagePath)
        
        navigationController?.popViewController(animated: true)
        }
    }
    
    func getImage(pet: Pet) {
        
        
        let imagePath = getDocumentsDirectory().appendingPathComponent("image\(pet.getId()).jpg").path
        if FileManager.default.fileExists(atPath: imagePath){
            let image = UIImage(contentsOfFile: imagePath)
            imageSelect.image = image
        }
    }
}
