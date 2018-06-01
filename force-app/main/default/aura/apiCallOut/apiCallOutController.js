({
    calloutCtrl: function(component, event, helper) {
  	// Default search query. 
    	//var query = "Salesforce");
    	let query = component.get("v.squery");
        //var location = '';
    	let location = component.get("v.location");
        //var distance = '';
    	let distance = component.get("v.distance");
        //var limit = 3;
    	let limit = component.get("v.limit");
        helper.getResponse(component, query, location, distance, limit);
  	},
 
})