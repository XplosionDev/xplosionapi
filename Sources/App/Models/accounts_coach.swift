import Vapor

//Create swift object class to store teams | Modified By: Todd Boone II
//Make class conform to Model which has JSONReprentable protocol
//The JSONRepresentable protocol allows node to JSON conversion
final class accounts_coach: Model {
    
    //add optional property to store unique id for this object
    var id: Node?
    //exist property keeps track on whether this entity was retrieved
    //from a db or whether it was created manually
    var exists: Bool = false
    
    var city: String
    var state: String
    var user_id: Int
    
    
    //Convenience initializer | Modified By: Todd Boone II
    init(city: String, state: String, user_id: Int) {
        self.id = nil
        self.city = city
        self.state = state
        self.user_id = user_id
    }
    
    
    //Initializer that creates model object from node that fluent created
    init(node: Node, in context: Context) throws {
        //pulls each item by keys created in makeNode
        id = try node.extract("id")
        city = try node.extract("city")
        state = try node.extract("state")
        user_id = try node.extract("user_id")
    }
    
    //This method returns a node | Modified By: Todd Boone II
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "city": city,
            "state": state,
            "user_id": user_id
            ])
    }
    
    //This method prepares the database | Modified By: Todd Boone II
    //***In other words: create table for first time
    static func prepare(_ database: Database) throws {
        try database.create("accounts_coachs") { users in
            users.id()
            users.string("city")
            users.string("state")
            users.int("user_id")
        }
    }
    
    //This method reverts the database | Modified By: Todd Boone II
    //***In other words: drop table
    //***only called if manually run command from command line
    static func revert(_ database: Database) throws {
        try database.delete("accounts_coachs")
    }
    
}
