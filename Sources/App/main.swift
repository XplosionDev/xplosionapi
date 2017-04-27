import Vapor
//Import database provider | Modified By: Todd Boone II
import VaporPostgreSQL

let drop = Droplet()

//Add database provider | Modified By: Todd Boone II
try drop.addProvider(VaporPostgreSQL.Provider.self)

//Prepares database with tables | Modified By: Todd Boone II
drop.preparations += Coach.self
drop.preparations += Player.self
drop.preparations += Swing.self
drop.preparations += Team.self


//RETURNS VAPOR WELCOME------------------------- | Modified By: Todd Boone II
//GET route '/' that returns the 'It works.' message | Modified By: Todd Boone II
drop.get { req in
    return try drop.view.make("welcome", [
        "message": drop.localization[req.lang, "welcome", "title"]
        ])
}

//RETURNS DATABASE VERSION---------------------- | Modified By: Todd Boone II
drop.get("version") { request in
    //use db property of droplet the droplet, which has the PostgreSQLDriver
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No database connection."
    }
}

//INSERTION OF MOCK DATA FOR TESTING------------- | Modified By: Todd Boone II

//Create new coach --> Saves it to the database --> returns JSON
drop.get("coach-insert") { request in
    var coach = Coach(city: "Fort Worth", state: "TX", user_id: 1)
    try coach.save()
    return try JSON(node: Coach.all().makeNode())
}

//Create new player --> Saves it to the database --> returns JSON
drop.get("player-insert") { request in
    var player = Player(email: "myemail@email.com", username: "myusername", password: "mypassword", type: "independent", first_name: "John", last_name: "Smith", hometown: "Fort Worth", homestate: "TX", height_feet: "6ft", height_inches: "2in", weight: "185", batting_orientation: "right", position: "pitcher", player_number: 13, team_id: 1)
    try player.save()
    return try JSON(node: Player.all().makeNode())
}

//Create new swing --> Saves it to the database --> returns JSON
drop.get("swing-insert") { request in
    var swing = Swing(swing_name: "", start_rot_x: 0, end_rot_x: 0, start_rot_y: 0, end_rot_y: 0, start_rot_z: 0, end_rot_z: 0, start_pos_x: 0, end_pos_x: 0, start_pos_y: 0, end_pos_y: 0, start_pos_z: 0, end_pos_z: 0, speed: 0, player_id: 1)
    try swing.save()
    return try JSON(node: Swing.all().makeNode())
}

//Create new team --> Saves it to the database --> returns JSON
drop.get("team-insert") { request in
    var team = Team(team_name: "Boswell", mascot: "Pioneers", city: "Fort Worth", state: "TX", coach_id: 1)
    try team.save()
    return try JSON(node: Team.all().makeNode())
}

//CREATE------------------------------------------- | Modified By: Todd Boone II

//Post route that creates new coach object in database    //NEED TO FIGURE OUT HOW TO USE THIS ROUTE
drop.post("new-coach") { request in
    var coach = try Coach(node: request.json)
    try coach.save()
    return coach
}

//Post route that creates new swing object in database    //NEED TO FIGURE OUT HOW TO USE THIS ROUTE
drop.post("new-swing") { request in
    var swing = try Swing(node: request.json)
    try swing.save()
    return swing
}

//Post route that creates new player object in database   //NEED TO FIGURE OUT HOW TO USE THIS ROUTE
drop.post("new-player") { request in
    var player = try Player(node: request.json)
    try player.save()
    return player
}

//Post route that creates new team object in database    //NEED TO FIGURE OUT HOW TO USE THIS ROUTE
drop.post("new-team") { request in
    var team = try Team(node: request.json)
    try team.save()
    return team
}

//READ--------------------------------------------- | Modified By: Todd Boone II

//Get request that returns all coaches in database
drop.get("all-coaches") { request in
    return try JSON(node: Coach.all().makeNode())
}

//Get request that returns all swings in database
drop.get("all-swings") { request in
    return try JSON(node: Swing.all().makeNode())
}

//Get request that returns all players in database
drop.get("all-players") { request in
    return try JSON(node: Player.all().makeNode())
}

//Get request that returns all teams in database
drop.get("all-teams") { request in
    return try JSON(node: Team.all().makeNode())
}

//UPDATE-------------------------------------------



//DELETE-------------------------------------------



//run server
drop.run()
