
import Foundation

class ActiveUser {
    
    static let instance = ActiveUser()
    private init(){}
    
    let userDefaults = PersonalCapDependenceFactory.instance.makeUserDefaults()
    
    func getUser() -> User? {
        
        if let data = try? userDefaults.get(objectType: User.self,
                                            forKey: "ActiveUser"),
            let user = data {
            
            return user
        }
        return nil
        
    }
    
}
