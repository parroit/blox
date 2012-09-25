package code;

class UUID {
	
	public static function get() {
		return untyped __php__("uniqid()");
	}
	
}
