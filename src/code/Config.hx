package code;

class Config {
	public static var vars;
	
	public static function __init__(){
		vars = haxe.Json.parse(sys.io.File.getContent("config.json"));
	}
	
	
}
