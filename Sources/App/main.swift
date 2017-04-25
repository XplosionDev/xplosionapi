import Vapor
//Import database provider | Modified By: Todd Boone II
import VaporPostgreSQL

let drop = Droplet()

//Add database provider | Modified By: Todd Boone II
try drop.addProvider(VaporPostgreSQL.Provider.self)

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

//GET route '/' that returns the 'It works.' message | Modified By: Todd Boone II
drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

//run server
drop.run()
