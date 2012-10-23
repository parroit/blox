

class Model {
	public function new() { 
		var cnx = php.db.Mysql.connect({
			"host" : "localhost",
			"port" : null,
			"user" : "root",
			"pass" : "porta111",
			"database" : "blox",
			"socket" : null
		});
		php.db.Manager.cnx=cnx;
		sys.db.Manager.cnx=cnx;
		sys.db.Manager.initialize();
		php.db.Manager.initialize();
		
	}
	
}
