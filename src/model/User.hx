package model;

import sys.db.Types;
import  introspector.Persistent;
import  thx.validation.StringLengthValidator;
@:id(id)
@:table("users")
class User extends sys.db.Object,	implements Persistent{

    public var id:SInt;

	@autoform({
		"title" : "User name", 
		"description" : "Your account login."}
	)
	public var username:SString<100>;

	@autoform({
		"widget" : "password", 
		"title" : "Password", 
		"description" : "Your account password.",
		"validation": "![new thx.validation.StringLengthValidator(1, 100)]"
	})
	public var password:SString<100>;

	@autoform({
		"title" : "E-mail", 
		"description" : "Your account primary email."
	})
	public var email:SString<100>;
	

	@autoform({
		"widget" : "checkbox",
		"title" : "Remember", 
		"description" : "Remember login status."
	})	
	public var remember:SBool;
	


	public var confirmationId:SString<100>;
	
}
