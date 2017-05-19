// This file provides the following api endpoints:
// http://localhost:8080/ | displays the vapor default It Works message
// http://localhost:8080/dbversion | returns database version of app
// http://localhost:8080/dbname | returns the name of the database being used
// http://localhost:8080/coaches | returns coach data
// http://localhost:8080/players | returns player data
// http://localhost:8080/swings | returns swing data
// http://localhost:8080/teams | returns teams data


import Vapor
//Import database provider | Modified By: Todd Boone II
import VaporPostgreSQL

let drop = Droplet()

//Add database provider | Modified By: Todd Boone II
try drop.addProvider(VaporPostgreSQL.Provider.self)

//Prepares database with tables | Modified By: Todd Boone II
drop.preparations += accounts_coach.self
drop.preparations += accounts_player.self
drop.preparations += accounts_swing.self
drop.preparations += accounts_team.self


//RETURNS VAPOR WELCOME------------------------- | Modified By: Todd Boone II
//GET route '/' that returns the 'It works.' message | Modified By: Todd Boone II
drop.get { req in
    return try drop.view.make("welcome", [
        "message": drop.localization[req.lang, "welcome", "title"]
        ])
}

//RETURNS DATABASE VERSION---------------------- | Modified By: Todd Boone II
drop.get("dbversion") { request in
    //use db property of droplet the droplet, which has the PostgreSQLDriver
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No database connection."
    }
}

//RETURNS DATABASE VERSION---------------------- | Modified By: Todd Boone II
drop.get("dbname") { request in
    //use db property of droplet the droplet, which has the PostgreSQLDriver
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let name = try db.raw("SELECT current_database()")
        return try JSON(node: name)
    } else {
        return "No database connection."
    }
}

//INSERTION OF MOCK DATA FOR TESTING------------- | Modified By: Todd Boone II

//Create new player --> Saves it to the database --> returns JSON
drop.get("player-insert") { request in
    var player = accounts_player(email: "myemail@email.com", username: "myusername", password: "password", type: "independent", first_name: "Joe", last_name: "Bob", hometown: "Fort Worth", homestate: "TX", height_feet: "6ft", height_inches: "2in", weight: "185", batting_orientation: "right", position: "pitcher", player_number: 13, team_id: 1)
    try player.save()
    return try JSON(node: accounts_player.all().makeNode())
}

//Create new swing --> Saves it to the database --> returns JSON
drop.get("swing-insert") { request in
    var swing = accounts_swing(start_rot: 0, end_rot: 0, start_pos_x: 0, end_pos_x: 0, start_pos_y: 0, end_pos_y: 0, start_pos_z: 0, end_pos_z: 0, speed: 0, player_id: 1)
    try swing.save()
    return try JSON(node: accounts_swing.all().makeNode())
}


//CREATE------------------------------------------- | Modified By: Todd Boone II

//Post route that creates new player object in database   //NEED TO FIGURE OUT HOW TO USE THIS ROUTE
drop.post("new-player") { request in
    var player = try accounts_player(node: request.json)
    try player.save()
    return player
}

//READ--------------------------------------------- | Modified By: Todd Boone II

//Get request that returns all coaches in database
drop.get("coaches") { request in
    return try JSON(node: accounts_coach.all().makeNode())
}

//Get request that returns all swings in database
drop.get("swings") { request in
    return try JSON(node: accounts_swing.all().makeNode())
}

//Get request that returns all players in database
drop.get("players") { request in
    return try JSON(node: accounts_player.all().makeNode())
}

//Get request that returns all teams in database
drop.get("teams") { request in
    return try JSON(node: accounts_team.all().makeNode())
}

//UPDATE-------------------------------------------

//


//DELETE-------------------------------------------



//run server
drop.run()
