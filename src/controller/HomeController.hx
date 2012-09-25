package controller;

class HomeController extends ufront.web.mvc.Controller {
	public function new(){super();}
	
	public function delete(key:String) {
		var user = model.User.manager.get(key);
		if(user != null) {
			user.delete();
		}
		return new ufront.web.mvc.RedirectResult("/");
	}


	public function save(key:String = null) {
		if(key == null) {
			key = "";
		}
		
		
		var user = if (key == "")  null else model.User.manager.get(key, null);

		var copyProps = function (user:model.User) {
			user.name = controllerContext.request.post.get("key");
			user.password = controllerContext.request.post.get("password");
		};


		if(user == null) {
			user = new model.User();
			copyProps(user);
			user.insert();
		} else {
			copyProps(user);
			user.update();
		}
		return new ufront.web.mvc.RedirectResult("/edit/" + key);
	}
	public function edit(key:String = null) {
		if(key == null) {
			key = "";
		}
		var user = if (key == "")  new model.User() else model.User.manager.get(key);
		Sys.println(key);
		return new ufront.web.mvc.ViewResult({"user" : user, "str" : StringTools});
	}
	
	public function index() {
		var users = model.User.manager.all();
		return new ufront.web.mvc.ViewResult({"users" : users, "str" : StringTools, "params" : ""});
	}
	public override function onAuthorization(filterContext) {
		code.DatabaseAuthAdapter.requireAuthorization("/login", filterContext);
	}
	
}
