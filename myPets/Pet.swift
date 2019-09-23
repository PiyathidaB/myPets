import Foundation
import RealmSwift

class Pet: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var weight: Int = 0
    @objc dynamic var favorite: String = ""
    @objc dynamic var imageName: String = ""
    
  override static func primaryKey() -> String? {
        return "id"
    }
    
    func getId() ->  Int {
        return id
    }
   
    
}
