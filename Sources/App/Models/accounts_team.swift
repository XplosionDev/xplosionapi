import Vapor

//Create swift object class to store teams | Modified By: Todd Boone II
//Make class conform to Model which has JSONReprentable protocol
//The JSONRepresentable protocol allows node to JSON conversion
final class accounts_team: Model {
    
    //add optional property to store unique id for this object
    var id: Node?
    //exist property keeps track on whether this entity was retrieved
    //from a db or whether it was created manually
    var exists: Bool = false
    
    var team_name: String
    var mascot: String
    var city: String
    var state: String
    var coach_id: Int
    
    
    //Convenience initializer | Modified By: Todd Boone II
    init(team_name: String, mascot: String, city: String, state: String, coach_id: Int) {
        self.id = nil
        self.team_name = team_name
        self.mascot = mascot
        self.city = city
        self.state = state
        self.coach_id = coach_id
    }
    
    
    //Initializer that creates model object from node that fluent created
    init(node: Node, in context: Context) throws {
        //pulls each item by keys created in makeNode
        id = try node.extract("id")
        team_name = try node.extract("team_name")
        mascot = try node.extract("mascot")
        city = try node.extract("city")
        state = try node.extract("state")
        coach_id = try node.extract("coach_id")
    }
    
    //This method returns a node | Modified By: Todd Boone II
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "team_name": team_name,
            "mascot": mascot,
            "city": city,
            "state": state,
            "coach_id": coach_id
            ])
    }
    
    //This method prepares the database | Modified By: Todd Boone II
    //***In other words: create table for first time
    static func prepare(_ database: Database) throws {
        try database.create("accounts_teams") { users in
            users.id()
            users.string("team_name")
            users.string("mascot")
            users.string("city")
            users.string("state")
            users.int("coach_id")
        }
    }
    
    //This method reverts the database | Modified By: Todd Boone II
    //***In other words: drop table
    //***only called if manually run command from command line
    static func revert(_ database: Database) throws {
        try database.delete("accounts_teams")
    }
    
}
