package code;

/**
 * ...
 * @author Andrea Parodi
 */
import thx.validation.Validator;
import thx.util.Result;
using thx.util.Results;

class SafeXmlValidator extends Validator<String>
{
    private var allowedTags:Hash<String>;
    private var allowedAttributes:Hash<String>;
    private var forbiddenAttributeContent:List<String>;
    public function new()
    {
        this.allowedAttributes=new Hash<String>();
        this.allowedTags=new Hash<String>();
        this.forbiddenAttributeContent=new List<String>();
    }

    function check(node:Xml):String{
        if(node.nodeType!=Xml.Document){
            if (!allowedTags.exists(node.nodeName.toLowerCase()))
                return "Tag "+node.nodeName+ " is not allowed.";

            for (attr in node.attributes())
                if (!allowedAttributes.exists(attr.toLowerCase()))
                    return "Attribute "+attr+ " is not allowed.";
                else {
                    var stringContent=node.get(attr).toLowerCase();
                    for (content in forbiddenAttributeContent)
                        if (stringContent.indexOf(content,0)>=0)
                            return content+" not allowed in attribute ";
                }
        }

        for (child in node.elements()){
            var result:String=check(child);
            if (result!=null)
                return result;

        }
        return null;
    }
    override public function validate(value : String)
    {
        var html:Xml;
        try{
            html=Xml.parse(value);

        } catch (e:Dynamic){
            return ("Content is not valid xhtml:" + Std.string(e)).failure();
        }

        var result:String=check(html);
        if (result!=null)
            return result.failure()
        else
            return Ok;
    }
}