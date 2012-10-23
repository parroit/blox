package model;

import sys.db.Types;

import  introspector.Persistent;


class Page extends sys.db.Object,	implements Persistent{

    public function myAuthor(){
        return User.manager.get(Reflect.field(this,"author_id"));
    }

	@autoform({
		"widget" : "html"
	})
	public var content:SText;

	@autoform({
		"title" : "Title",
        "validation": "![new thx.validation.StringLengthValidator(1, 100)]"
	})
	public var title:SString<100>;

	@autoform({
		"title" : "Author" 
	})
    @:relation(author_id)
	public var author:User;

	public var id:SId;


	public var confirmationId:SString<100>;

    @autoform({
    "title" : "Tags",
    "validation": "![new thx.validation.StringLengthValidator(1, 200)]"
    })
    public var tags:SString<200>;

}
