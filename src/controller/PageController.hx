package controller;
import ufront.web.mvc.ActionResult;
import autoform.AutoForm;
import sys.db.Manager;
import model.Page;
import model.User;
using autoform.Introspection;
import ufront.web.mvc.Controller;
import ufront.web.mvc.ViewResult;
import ufront.web.mvc.RedirectResult;

using controller.AutoformRequest;

class PageController extends Controller {
	public function detail(key:Int) {
		
		var model:Page = Page.manager.get(key);

		return new ViewResult( {data : model});	
	}
	
	public function list() {


		var models = Page.manager.search($author==loggedUser);
		
		return new ViewResult( {data:models});	
	}

	public function save(key:Int):ActionResult {

		var page = if (key == 0)  null else Page.manager.get(key);
		var editForm:AutoForm = new AutoForm().of(Page,["title","content"]);

		editForm.fillFromRequest(this.controllerContext.request);
        if(autoform.Validation.validate(editForm)) {
            if(page == null) {
                page = new model.Page();
                editForm.toModel(page);
                page.author=loggedUser;
                page.insert();
                key=page.id;
            } else {
                editForm.toModel(page);
                page.update();
            }
            return new RedirectResult("/page/edit/" + key);
        } else {
            return new ViewResult( {editForm:editForm,key:key});
        }
	}
    public function new(){
        super();
    }

    public function edit(key:Int) {
		
		var model = if (key==0) new Page() else Page.manager.get(key);


        var editForm:AutoForm = new AutoForm().of(Page,["title","content"]);
		editForm.fill(model);
		editForm.meta.fields.content.displayOptions={
			rows:80,
			cols:100,
			additionalClasses:"span11"
		};
		
		editForm.meta.fields.title.displayOptions={
			additionalClasses:"span11"
		};

		
		
		return new ViewResult( {editForm:editForm,key:key});	
	}
    private var loggedUser:model.User;

    public override function onAuthorization(filterContext) {

        loggedUser=code.DatabaseAuthAdapter.requireAuthorization("/login", filterContext);

    }
}