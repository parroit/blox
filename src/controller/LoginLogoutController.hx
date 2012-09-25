package controller;

class LoginLogoutController extends ufront.web.mvc.Controller {
	private static var editForm;
	private static var registerForm;

	public static function __init__() {
		
		var newUser = new model.User();
		editForm = autoform.Reflection.of(new autoform.AutoForm(), Type.getClass(newUser), ["name", "password", "remember"]);
		registerForm = autoform.Reflection.of(new autoform.AutoForm(), Type.getClass(newUser), ["name", "email"]);
		
		untyped {


			autoform.Validation.addRule(editForm.meta.fields.name, 
				new thx.validation.StringLengthValidator(1, 100));
			autoform.Validation.addRule(editForm.meta.fields.password, 
				new thx.validation.StringLengthValidator(1, 100));
		
		
			autoform.Validation.addRule(registerForm.meta.fields.name, 
				new thx.validation.StringLengthValidator(1, 100));
			autoform.Validation.addRule(registerForm.meta.fields.email, 
				new thx.validation.StringLengthValidator(1, 100));
		}
	}

	public function dologout() {
		var session = this.controllerContext.httpContext.session;
		session.setLifeTime(0);
		session.clear();
		return new ufront.web.mvc.RedirectResult("/");
	}
	public function register() {
		controller.AutoformRequest.fillFromRequest(registerForm, this.controllerContext.request);
		var result:ufront.web.mvc.ActionResult = null;
		if(autoform.Validation.validate(registerForm)) {
			var newUser = new model.User();
			autoform.Reflection.toModel(registerForm, newUser);
			newUser.confirmationId = code.UUID.get();
			newUser.password = code.UUID.get().substr( 0, 10);
			newUser.insert();
			var host = code.Config.vars.web.host;
			var message = "<html><body>                    
				<p>
				Dear ${newUser.name}<br/>
				Welcome to <strong>Blox</strong> and thank you for your interest in our product!<br/>                    
				Your registration was successful. Please, keep this mail for future reference.                     
				</p>                    
				<p>                    
				Your login data:<br/><br/>                    
				User name: ${newUser.name}<br/>
				Password:  ${newUser.password}<br/></p>
				In order to login to Blox site you have to confirm your mail address.<br/>                                        
				<a href='@{host}confirm/${newUser.confirmationId}''>
				<strong>Click here to confirm mail address and login.</strong>                    
				</a>
				</body></html>            
			";
			

			
			code.Mailer.send("no-reply@blox.it", newUser.email, "You have registered at blox.it", message);
			result = new ufront.web.mvc.RedirectResult("/register-successfully");
		} else {
			result = new ufront.web.mvc.ViewResult({"form" : editForm, "registerForm" : registerForm});
		}
		return result;
	}
	public function registerSuccessfully() {
		return new ufront.web.mvc.ViewResult({});
	}
	public function confirm(id:String) {
		var users = model.User.manager.search($confirmationId==id);
		if(!users.isEmpty()) {
			var user = users.first();
			user.confirmationId = null;
			user.update();
			return new ufront.web.mvc.ViewResult( {"message" : "Congratulation, your account was succesfuly activated. You are now able to login with your username and password."});
		}
		return new ufront.web.mvc.ViewResult({"message" : "It appear either that you already activate your account, or that you use an invalid id."});
	}

	public function dologin() {
		var session = this.controllerContext.httpContext.session;
		autoform.Validation.addFormRule(editForm, new controller.ValidateUser(session));
		controller.AutoformRequest.fillFromRequest(editForm, this.controllerContext.request);
		var result:ufront.web.mvc.ActionResult = null;
		if(editForm.data.fields.remember.value) {
			var lifetime = 10*24*60;
			session.setLifeTime(lifetime);
		}
		if(autoform.Validation.validate(editForm)) {
			result = new ufront.web.mvc.RedirectResult("/");
		} else {
			autoform.Reflection.fill(registerForm, new model.User());
			result = new ufront.web.mvc.ViewResult( {"form" : editForm, "registerForm" : registerForm});
		}
		return result;
	}
	public function login() {
		var newUser = new model.User();
		autoform.Reflection.fill(editForm, newUser);
		autoform.Reflection.fill(registerForm, newUser);
		return new ufront.web.mvc.ViewResult( {"form" : editForm, "registerForm" : registerForm});
	}
	
}
