import UIKit

class PetCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthdayLable: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var imageName: UIImageView!
    
    func setUpCell(pet: Pet){
        nameLabel.text = pet.name
        birthdayLable.text = "\(pet.birthday)"
        ageLabel.text = "\(pet.age)"
        idLabel.text = "\(pet.id)"
        getImage(pet: pet)
    }
    
    func getImage(pet: Pet) {
        
        imageName.layer.cornerRadius = imageName.frame.size.height/2
        imageName.clipsToBounds = true
        
        let imagePath = getDocumentsDirectory().appendingPathComponent("image\(pet.getId()).jpg").path
        if FileManager.default.fileExists(atPath: imagePath){
            let image = UIImage(contentsOfFile: imagePath)
            imageName.image = image
        }
        
    }
    //path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

}
