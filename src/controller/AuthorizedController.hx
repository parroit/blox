package controller;
import ufront.web.mvc.Controller;
class AuthorizedController extends Controller{

    public function new(){
        super();
    }

    private var loggedUser:model.User;

    public override function onAuthorization(filterContext) {

        loggedUser=code.DatabaseAuthAdapter.requireAuthorization("/login", filterContext);

    }
}
