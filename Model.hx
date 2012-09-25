

class Model {
	public function new() { 
		var cnx = php.db.Mysql.connect({
			"host" : "localhost",
			"port" : null,
			"user" : "root",
			"pass" : "***",
			"database" : "blox",
			"socket" : null
		});
		php.db.Manager.cnx=cnx;
		sys.db.Manager.cnx=cnx;
	}
	
}
