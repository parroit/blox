package code;
import ufront.web.mvc.ViewContext;
using StringTools;
import autoform.AutoForm;
import autoform.renderer.HtmlDocument;
using autoform.renderer.HtmlDocument;
using autoform.renderer.HtmlTag;
using autoform.domrenderer.DomRenderingEngine;
using autoform.bootstraprenderer.BootstrapRenderingEngine;

/********************************************************************************
 *
 *	This helper allow easy rendering of information
 *	
 *	Controllers has to return an AutoForm instance to view, that
 *  could be rendered using either domRender method for standard 
 *  HTML renddering, or bootstrapRender for <a href="http://twitter.github.com/bootstrap/" >Twitter bootstrap</a>
 *	rendering.
 *	
**********************************************************************************/
class AuthHelper implements ufront.web.mvc.IViewHelper
{
	public var name(default, null) : String;
    private var user:model.User;
    public function new(user:model.User,name = "Auth")
	{
		this.name = name;
        this.user=user;
	}

	public function register(data : Hash<Dynamic>)
	{
		data.set(name, new AuthHelperInst(user));
	}
}


/********************************************************************************
 *
 *	This class is the implementation of FormHelper helper.trace
 *  See FormHelper documentation for details.
 *	
**********************************************************************************/
class AuthHelperInst
{

    private var user:model.User;
    public function new(user:model.User)
    {

        this.user=user;
    }


/********************************************************************************
 *
 *	Allow to render a form to <a href="http://twitter.github.com/bootstrap/" >Twitter bootstrap</a>
 *	based HTML.
 *	@Param form 			The form to render
 *  @Param action			The value of the action attribute of rendered form
 *  @Param defaultSubmit	HTML representing one or more submit tag to add to end of form
 *
**********************************************************************************/
	public function userIsLogged():Bool
	{
        return user!=null;
	}

    public function userDescription():String
    {
        return if ( userIsLogged()) user.username else "anonymous";
    }

}