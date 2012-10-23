package controller;


class HomeController extends ufront.web.mvc.Controller {
	public function new(){super();}
	
	public function delete(key:Int) {
		var user = model.User.manager.get(key);
		if(user != null) {
			user.delete();
		}
		return new ufront.web.mvc.RedirectResult("/");
	}


	public function save(key:Int = null) {
		if(key == null) {
			key = 0;
		}
		
		
		var user = if (key == 0)  null else model.User.manager.get(key);

		var copyProps = function (user:model.User) {
			user.username = controllerContext.request.post.get("username");
            user.email = controllerContext.request.post.get("email");
			user.password = controllerContext.request.post.get("password");
		};


		if(user == null) {
			user = new model.User();
			copyProps(user);
			user.insert();
            key=user.id;
		} else {
			copyProps(user);
			user.update();
		}
		return new ufront.web.mvc.RedirectResult("/edit/" + key);
	}
	public function edit(key:Int = null) {

		if(key == null) {
			key = 0;
		}
		var user = if (key == 0)  new model.User() else model.User.manager.get(key);
		
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
