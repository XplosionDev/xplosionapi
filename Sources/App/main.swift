import Vapor
//Import database provider | Modified By: Todd Boone II
import VaporPostgreSQL

let drop = Droplet()

//Add database provider | Modified By: Todd Boone II
try drop.addProvider(VaporPostgreSQL.Provider.self)

//Prepares database with Team table | Modified By: Todd Boone II
drop.preparations += Team.self

//GET route '/' that returns the 'It works.' message | Modified By: Todd Boone II
drop.get { req in
    return try drop.view.make("welcome", [
        "message": drop.localization[req.lang, "welcome", "title"]
        ])
}

//GET route '/version' that returns database version | Modified By: Todd Boone II
drop.get("version") { request in
    //use db property of droplet the droplet, which has the PostgreSQLDriver
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No database connection."
    }
}

//Vapor route that creates Team object and return as JSON
drop.get("model") { request in
    let team = Team(/* coach: "", */teamname: "testTeam", mascot: "testers", city: "testville", state: "testin")
    return try team.makeJSON()
}

//Test Team class
//Create new team --> Saves it to the database --> returns JSON
drop.get("test") { request in
    var team = Team(/* coach: "", */teamname: "testTeam", mascot: "testers", city: "testville", state: "testin")
    try team.save()
    return try JSON(node: Team.all().makeNode())
}

//CREATE------------------------------------------

//Post route that creates new object in database
drop.post("new") { request in
    var team = try Team(node: request.json)
    try team.save()
    return team
}

//READ---------------------------------------------


//Get request that returns all teams in database
drop.get("allteams") { request in
    return try JSON(node: Team.all().makeNode())
}

//Get request that returns first team in database
drop.get("first") { request in
    return try JSON(node: Team.query().first()?.makeNode())
}

//Get request that returns all teams with specific attribute values
//specified attribute: state -> testin
drop.get("testin") { request in
    return try JSON(node: Team.query().filter("state", "testin").all().makeNode())
}

//Get request that returns all teams WITHOUT specific attribute values
//specified attribute: state -> testin
drop.get("not-testin") { request in
    return try JSON(node: Team.query().filter("state", .notEquals, "testin").all().makeNode())
}

//UPDATE-------------------------------------------

//GET route that will allow us to override value for specified attribute of first team
//specified attribute: city, specified value: testcity
//execute w/ '/update?city=testcity'
drop.get("update") { request in
    //gets the first team
    guard var first = try Team.query().first(),
        let city = request.data["city"]?.string else {
            throw Abort.badRequest
    }
    first.city = city
    try first.save()
    return first
}

//UPDATE-------------------------------------------

//GET route that deletes any entries with specified value
//specified value: city -> testcity
drop.get("delete-testcity") { request in
    let query = try Team.query().filter("city", "testcity")
    try query.delete()
    return try JSON(node: Team.all().makeNode())
}

//run server
drop.run()
