package controller;

class AutoformRequest {
	
	public static function fillFromRequest(form:autoform.AutoForm, request:ufront.web.HttpRequest) {
		
			
			var fields = Reflect.fields(form.meta.fields);
			for (fld in fields) {
				if(fld != "manager") {
					var fieldMeta = Reflect.getProperty(form.meta.fields, fld);
					var postValue:Dynamic = null;
					if(fieldMeta.widget == "checkbox") {
						postValue = request.post.exists(fld);
					} else {
						postValue = request.post.get(fld);
					}
					
					var fieldValue = {
						"error" : thx.util.Result.Ok, 
						"value" : postValue, 
						"meta" : fieldMeta
					};

					Reflect.setField(form.data.fields,fieldMeta.name, fieldValue);

					
				}
				
			}
		
		return form;
	}
	
}
