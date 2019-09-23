import Foundation
import RealmSwift

class Database {
    
    static func pet() -> Results<Pet> {
        let realm = try! Realm()
        
        return realm.objects(Pet.self)
    }
    
    static func getPet(id: Int) -> Pet? {
        
        let realm = try! Realm()
        
        return realm.object(ofType: Pet.self, forPrimaryKey: id)
    }
    
    //add data pet
    static func addPet(name: String ,type: String ,birthday: String ,age: Int ,weight: Int ,favorite: String ) -> Int{
        
        let realm = try! Realm()
        let newId = ( realm.objects(Pet.self).max(ofProperty: "id") ?? 0 ) + 1
        
        let pet = Pet()
        pet.id = newId
        pet.name = name
        pet.type = type
        pet.birthday = birthday
        pet.age = age
        pet.weight = weight
        pet.favorite = favorite
        
        
        
        
        //save it
        
        try! realm.write {
            realm.add(pet)
        }
        
        return pet.id
        
    }
    
    //add photo
    static func addPhoto(_ path: String){
        let photo = Photo()
        photo.path = path
        let realm = try! Realm()
        try! realm.write {
            realm.add(photo)
        }
    }
    
    static func addNameImage(_ imageName: String) {
        let realm = try! Realm()
        let nameImage = Pet()
        nameImage.imageName = imageName
        try! realm.write {
            realm.add(nameImage)
        }
    }
    
    //delete
    static func deletePet(myPets: Pet){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(myPets)
        }
    }
        
    //update
    static func updatePet(id: Int ,name: String ,type: String ,birthday: String ,age: Int ,weight: Int ,favorite: String){
        if let pet = Database.getPet(id: id) {
            let realm = try! Realm()
            try! realm.write {
                pet.name = name
                pet.type = type
                pet.birthday = birthday
                pet.age = age
                pet.weight = weight
                pet.favorite = favorite
                
                
            }
        }
    }
}
    

