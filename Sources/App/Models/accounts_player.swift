import Vapor

//Create swift object class to store teams | Modified By: Todd Boone II
//Make class conform to Model which has JSONReprentable protocol
//The JSONRepresentable protocol allows node to JSON conversion
final class accounts_player: Model {
    
    //add optional property to store unique id for this object
    var id: Node?
    //exist property keeps track on whether this entity was retrieved
    //from a db or whether it was created manually
    var exists: Bool = false
    
    var email: String
    var username: String
    var password: String
    var type: String
    var first_name: String
    var last_name: String
    var hometown: String
    var homestate: String
    var height_feet: String
    var height_inches: String
    var weight: String
    var batting_orientation: String
    var position: String
    var player_number: Int
    var team_id: Int
    
    
    //Convenience initializer | Modified By: Todd Boone II
    init(email: String, username: String, password: String, type: String, first_name: String, last_name: String, hometown: String,
         homestate: String, height_feet: String, height_inches: String, weight: String, batting_orientation: String, position: String,
         player_number: Int, team_id: Int) {
        self.id = nil
        self.email = email
        self.username = username
        self.password = password
        self.type = type
        self.first_name = first_name
        self.last_name = last_name
        self.hometown = hometown
        self.homestate = homestate
        self.height_feet = height_feet
        self.height_inches = height_inches
        self.weight = weight
        self.batting_orientation = batting_orientation
        self.position = position
        self.player_number = player_number
        self.team_id = team_id
    }
    
    
    //Initializer that creates model object from node that fluent created
    init(node: Node, in context: Context) throws {
        //pulls each item by keys created in makeNode
        id = try node.extract("id")
        email = try node.extract("email")
        username = try node.extract("username")
        password = try node.extract("password")
        type = try node.extract("type")
        first_name = try node.extract("first_name")
        last_name = try node.extract("last_name")
        hometown = try node.extract("hometown")
        homestate = try node.extract("homestate")
        height_feet = try node.extract("height_feet")
        height_inches = try node.extract("height_inches")
        weight = try node.extract("weight")
        batting_orientation = try node.extract("batting_orientation")
        position = try node.extract("position")
        player_number = try node.extract("player_number")
        team_id = try node.extract("team_id")
    }
    
    //This method returns a node | Modified By: Todd Boone II
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "email": email,
            "username": username,
            "password": password,
            "type": type,
            "first_name": first_name,
            "last_name": last_name,
            "hometown": hometown,
            "homestate": homestate,
            "height_feet": height_feet,
            "height_inches": height_inches,
            "weight": weight,
            "batting_orientation": batting_orientation,
            "position": position,
            "player_number": player_number,
            "team_id": team_id
            ])
    }
    
    //This method prepares the database | Modified By: Todd Boone II
    //***In other words: create table for first time
    static func prepare(_ database: Database) throws {
        try database.create("accounts_players") { users in
            users.id()
            users.string("email")
            users.string("username")
            users.string("password")
            users.string("type")
            users.string("first_name")
            users.string("last_name")
            users.string("hometown")
            users.string("homestate")
            users.string("height_feet")
            users.string("height_inches")
            users.string("weight")
            users.string("batting_orientation")
            users.string("position")
            users.int("player_number")
            users.int("team_id")
        }
    }
    
    //This method reverts the database | Modified By: Todd Boone II
    //***In other words: drop table
    //***only called if manually run command from command line
    static func revert(_ database: Database) throws {
        try database.delete("accounts_players")
    }
    
}
