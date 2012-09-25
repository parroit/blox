

class Engine {
	
	public static function main() {
		untyped __php__("ini_set('xdebug.max_nesting_level', 200);");
		
		thx.util.Imports.pack("controller",false);
		
		var config = new ufront.web.AppConfiguration("controller");
		var routes = new ufront.web.routing.RouteCollection();
		routes
		.addRoute("/", {"controller" : "home", "action" : "index"})
		.addRoute("/edit/{?name}", {"controller" : "home", "action" : "edit"})
		.addRoute("/save/{?name}", {"controller" : "home", "action" : "save"})
		.addRoute("/delete/{name}", {"controller" : "home", "action" : "delete"})
		.addRoute("/login", {"controller" : "loginLogout", "action" : "login"})
		.addRoute("/dologin", {"controller" : "loginLogout", "action" : "dologin"})
		.addRoute("/register", {"controller" : "loginLogout", "action" : "register"})
		.addRoute("/logout", {"controller" : "loginLogout", "action" : "dologout"})
		.addRoute("/confirm/{id}", {"controller" : "loginLogout", "action" : "confirm"})
		.addRoute("/register-successfully", {"controller" : "loginLogout", "action" : "registerSuccessfully"});
		
		var model = new Model();
		var app = new ufront.web.mvc.MvcApplication(config, routes);
		app.execute();
	}
	
}
