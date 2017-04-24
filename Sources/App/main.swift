import Vapor
//Import database provider | Modified By: Todd Boone II
import VaporPostgreSQL

let drop = Droplet(
    //Pass in provider | Modified By: Todd Boone II
    providers: [VaporPostgreSQL.Provider.self]
    
)

drop.get("version") { request in
    //use db property of droplet the droplet, which has the PostgreSQLDriver
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No database connection."
    }
}

/* THIS IS FOR THE VAPOR 'It Works.' message.************************************************************
drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}


drop.resource("posts", PostController())
********************************************************************************************************/

drop.run()
