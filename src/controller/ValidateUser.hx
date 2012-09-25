package controller;

class ValidateUser implements thx.validation.IValidator<Dynamic>{
	var session:ufront.web.IHttpSessionState;
	public function new(session:ufront.web.IHttpSessionState){
		this.session=session;

	}
	
	public function isValid(user) {
		return this.validate(user) == thx.util.Result.Ok;
	}
	public function validate(user) {
		var sessionStorage = new ufront.auth.storage.SessionStorage(this.session);
		var auth = new ufront.auth.Auth(sessionStorage);
		var dbAuth = new code.DatabaseAuthAdapter(user.name.value, user.password.value);
		var result = auth.authenticate(dbAuth);
		
		switch(result.message) {
			case Success:return thx.util.Result.Ok;
			case Failure(msg): return thx.util.Result.Failure([msg]);
			default: return thx.util.Result.Failure([new thx.util.Message("unable to login")]);
		}
		
	}
	

}
