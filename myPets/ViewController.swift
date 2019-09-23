import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageChoose: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // set tableView
    var petList = Database.pet()

    //set row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }

    //set row show
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "petcell", for: indexPath) as! PetCell
        
        let pet = petList[indexPath.row]
        cell.setUpCell(pet: pet)
        return cell
    }
    
    //set delete
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            Database.deletePet(myPets: petList[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //comeback to desktop
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // show data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if tableView.indexPathForSelectedRow != nil {
            let detailViewController = segue.destination as! DetailViewController
            let pet = petList[tableView.indexPathForSelectedRow!.row]
            detailViewController.pet = pet
        }
    }
    
    
}

