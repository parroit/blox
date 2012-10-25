package code;
import ufront.web.mvc.ViewContext;
import ufront.web.mvc.ControllerContext;
import ufront.web.mvc.ViewEngineResult;
import ufront.web.mvc.ViewResult;
class AuthViewResult extends ViewResult{
    private var user:model.User;
    public function new(user:model.User,?data : Hash<Dynamic>, ?dataObj : {}) {
        super(data,dataObj);
        this.user=user;
    }

    override function createContext(result : ViewEngineResult, controllerContext : ControllerContext)
    {
        var context=super.createContext(result,controllerContext);
        context.viewHelpers.push(new AuthHelper(user));
        return context;
    }


}
