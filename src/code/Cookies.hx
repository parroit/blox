package code;

class code_Cookies {
	public function __construct(){}
	static function add($name, $value, $expire, $path, $domain) {
		$result = false;
		
			
			result=(1==setcookie ( $name , $value,time()+$expire ));
			
		;
		if(!$result) {
			throw new HException("Cooky could not be set. Output already started.");
		}
	}
	function __toString() { return 'code.Cookies'; }
}
