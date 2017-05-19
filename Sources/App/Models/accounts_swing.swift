import Vapor

//Create swift object class to store teams | Modified By: Todd Boone II
//Make class conform to Model which has JSONReprentable protocol
//The JSONRepresentable protocol allows node to JSON conversion
final class accounts_swing: Model {
    
    //add optional property to store unique id for this object
    var id: Node?
    //exist property keeps track on whether this entity was retrieved
    //from a db or whether it was created manually
    var exists: Bool = false
    
    var start_rot: Double
    var end_rot: Double
    var start_pos_x: Double
    var end_pos_x: Double
    var start_pos_y: Double
    var end_pos_y: Double
    var start_pos_z: Double
    var end_pos_z: Double
    var speed: Double
    var player_id: Int
    
    
    //Convenience initializer | Modified By: Todd Boone II
    init(start_rot: Double, end_rot: Double, start_pos_x: Double, end_pos_x: Double, start_pos_y: Double, end_pos_y: Double, start_pos_z: Double,
         end_pos_z: Double, speed: Double, player_id: Int) {
        self.id = nil
        self.start_rot = start_rot
        self.end_rot = end_rot
        self.start_pos_x = start_pos_x
        self.end_pos_x = end_pos_x
        self.start_pos_y = start_pos_y
        self.end_pos_y = end_pos_y
        self.start_pos_z = start_pos_z
        self.end_pos_z = end_pos_z
        self.speed = speed
        self.player_id = player_id
    }
    
    
    //Initializer that creates model object from node that fluent created
    init(node: Node, in context: Context) throws {
        //pulls each item by keys created in makeNode
        id = try node.extract("id")
        start_rot = try node.extract("start_rot")
        end_rot = try node.extract("end_rot")
        start_pos_x = try node.extract("start_pos_x")
        end_pos_x = try node.extract("end_pos_x")
        start_pos_y = try node.extract("start_pos_y")
        end_pos_y = try node.extract("end_pos_y")
        start_pos_z = try node.extract("start_pos_z")
        end_pos_z = try node.extract("end_pos_z")
        speed = try node.extract("speed")
        player_id = try node.extract("player_id")
    }
    
    //This method returns a node | Modified By: Todd Boone II
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "start_rot": start_rot,
            "end_rot": end_rot,
            "start_pos_x": start_pos_x,
            "end_pos_x": end_pos_x,
            "start_pos_y": start_pos_y,
            "end_pos_y": end_pos_y,
            "start_pos_z": start_pos_z,
            "end_pos_z": end_pos_z,
            "speed": speed,
            "player_id": player_id
            ])
    }
    
    //This method prepares the database | Modified By: Todd Boone II
    //***In other words: create table for first time
    static func prepare(_ database: Database) throws {
        try database.create("accounts_swings") { users in
            users.id()
            users.double("start_rot")
            users.double("end_rot")
            users.double("start_pos_x")
            users.double("end_pos_x")
            users.double("start_pos_y")
            users.double("end_pos_y")
            users.double("start_pos_z")
            users.double("end_pos_z")
            users.double("speed")
            users.int("player_id")
        }
    }
    
    //This method reverts the database | Modified By: Todd Boone II
    //***In other words: drop table
    //***only called if manually run command from command line
    static func revert(_ database: Database) throws {
        try database.delete("accounts_swings")
    }
    
}
