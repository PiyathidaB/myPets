import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var favoriteLabel: UILabel!
    @IBOutlet weak var imageSelete: UIImageView!
    
    var pet : Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let editViewController = segue.destination as! EditViewController
        
        editViewController.pet = pet!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pet = pet {
            
            nameLabel.text = pet.name
            typeLabel.text = pet.type
            birthdayLabel.text = pet.birthday
            ageLabel.text = "\(pet.age)"
            weightLabel.text = "\(pet.weight)"
            favoriteLabel.text = pet.favorite
            getImage(pet: pet)
        }
    }
    
    func getImage(pet: Pet) {

        
        let imagePath = getDocumentsDirectory().appendingPathComponent("image\(pet.getId()).jpg").path
        if FileManager.default.fileExists(atPath: imagePath){
            let image = UIImage(contentsOfFile: imagePath)
            imageSelete.image = image
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
