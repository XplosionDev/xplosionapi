import Vapor

//Create swift object class to store teams | Modified By: Todd Boone II
//Make class conform to Model which has JSONReprentable protocol
//The JSONRepresentable protocol allows node to JSON conversion
final class Team: Model {
    
    //add optional property to store unique id for this object
    var id: Node?
    //exist property keeps track on whether this entity was retrieved
    //from a db or whether it was created manually
    var exists: Bool = false
    
    /* var coach: String */
    var teamname: String
    var mascot: String
    var city: String
    var state: String
    
    
    //Convenience initializer | Modified By: Todd Boone II
    init(/* coach: String, */ teamname: String, mascot: String, city: String, state: String) {
        self.id = nil
        /* self.coach = coach */
        self.teamname = teamname
        self.mascot = mascot
        self.city = city
        self.state = state
    }
 
    
    //Initializer that creates model object from node that fluent created
    init(node: Node, in context: Context) throws {
        //pulls each item by keys created in makeNode
        id = try node.extract("id")
        /* coach = try node.extract("coach") */
        teamname = try node.extract("teamname")
        mascot = try node.extract("mascot")
        city = try node.extract("city")
        state = try node.extract("state")
    }
    
    //This method returns a node | Modified By: Todd Boone II
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            /* "coach": coach, */
            "teamname": teamname,
            "mascot": mascot,
            "city": city,
            "state": state
        ])
    }
    
    //This method prepares the database | Modified By: Todd Boone II
    //***In other words: create table for first time
    static func prepare(_ database: Database) throws {
        //name it class name with 's' after "teams"
        try database.create("teams") { users in
            users.id()
            /* users.string("coach") */
            users.string("teamname")
            users.string("mascot")
            users.string("city")
            users.string("state")
        }
    }
    
    //This method reverts the database | Modified By: Todd Boone II
    //***In other words: drop table
    //***only called if manually run command from command line
    static func revert(_ database: Database) throws {
        try database.delete("teams")
    }
    
}
