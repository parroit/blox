package code;

/**
 * ...
 * @author Andrea Parodi
 */
import thx.validation.Validator;
import thx.util.Result;
using thx.util.Results;

class SafeHtmlValidator extends SafeXmlValidator
{
    public function new()
    {
        super();
        var safeTags="span,a,address,em,strong,b,i,big,small,sub,sup,cite,code,img,ul,ol,li,dl,lh,dt,dd,br,p,table,th,td,tr,pre,blockquote,nowiki,h1,h2,h3,h4,h5,h6,hr".split(",");
        for (tag in safeTags)
            this.allowedTags.set(tag,"");
        var safeAttrs="style,rev,prompt,color,colspan,accesskey,usemap,cols,accept,datetime,char,accept-charset,shape,href,hreflang,selected,frame,type,alt,nowrap,border,id,axis,compact,rows,checked,for,start,hspace,charset,ismap,label,target,bgcolor,readonly,rel,valign,scope,size,cellspacing,cite,media,multiple,src,rules,nohref,action,rowspan,abbr,span,method,height,class,enctype,lang,disabled,name,charoff,clear,summary,value,longdesc,headers,vspace,noshade,coords,width,maxlength,cellpadding,title,align,dir,tabindex".split(",");
        for (attr in safeAttrs)
            this.allowedAttributes.set(attr,"");
        this.forbiddenAttributeContent.add("javascript");
    }


}