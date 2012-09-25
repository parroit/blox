package model;


@:id(name)
@:table("users")
class User extends sys.db.Object,	implements haxe.rtti.Infos{

	
	
	
	@autoform({"title" : "User name", "description" : "Your account login."})
	public var name:sys.db.Types.SString<100>;

	@autoform({"widget" : "password", "title" : "Password", "description" : "Your account password."})
	public var password:sys.db.Types.SString<100>;

	@autoform({"title" : "E-mail", "description" : "Your account primary email."})
	public var email:sys.db.Types.SString<100>;
	

	@autoform({
		"widget" : "checkbox",
		 "title" : "Remember", 
		 "description" : "Remember login status."
	})	
	public var remember:sys.db.Types.SBool;
	


	public var confirmationId:sys.db.Types.SString<100>;
	
}
 