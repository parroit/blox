package model;

import sys.db.Types;

import  introspector.Persistent;


class Page extends sys.db.Object,	implements Persistent{

    public function myAuthor(){
        return User.manager.get(Reflect.field(this,"author_id"));
    }

	@autoform({
        title : "Page Content",
		widget : "html",
        validation: "![new code.SafeHtmlValidator()]"
	})
	public var content:SText;



	@autoform({
		title : "Title",
        validation: "![new thx.validation.StringLengthValidator(1, 100)]"
	})
	public var title:SString<100>;

    @:relation(author_id)
	@autoform({
		"title" : "Author" 
	})
    public var author:User;

	public var id:SId;


	public var confirmationId:SString<100>;

    @autoform({
    "title" : "Tags",
    "validation": "![new thx.validation.StringLengthValidator(1, 200)]"
    })
    public var tags:SString<200>;


    @autoform({
    "title" : "Date"

    })
    public var date:SDateTime;


}
