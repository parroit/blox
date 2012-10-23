package code;
import ufront.auth.AuthResult;
import ufront.auth.AuthResultMessage;
class DatabaseAuthAdapter implements ufront.auth.IAuthAdapter<Dynamic>{
	public function new(username :String, password:String) {
		
		this.username = username;
		this.password = password;
	}
	public function authenticate() {
		

        var user=model.User.manager.search($username==this.username).first();
        var message = {username : this.username, "realm" : ""};

        if(user != null && user.password == this.password) {
            if(user.confirmationId == "pending") {
                return new AuthResult(AuthResultMessage.Failure(new thx.util.Message("your account is pending approval by an administrator")), message);
            }
            if(user.confirmationId != null) {
                return new AuthResult(AuthResultMessage.Failure(new thx.util.Message("your account is not activated. Click on the link in registration email to activate it.")), message);
            }
            return new AuthResult(AuthResultMessage.Success, message);
        } else {
            return new AuthResult(AuthResultMessage.Failure(new thx.util.Message("username or password incorrect")), message);
        }

	}
	public var password:String;
	public var username:String;

	
	public static function requireAuthorization(redirectToUrl:String, filterContext:ufront.web.mvc.AuthorizationContext):model.User {

        var sessionStorage = new ufront.auth.storage.SessionStorage(filterContext.controllerContext.httpContext.session);
		var auth = new ufront.auth.Auth(sessionStorage);
		var identity = auth.getIdentity();

		if(identity == null) {
			filterContext.result = new ufront.web.mvc.RedirectResult(redirectToUrl);
            return null;
        } else
            {
                var name:String=identity.username;
                return model.User.manager.search($username==name).first();
            }


	}
	
}
