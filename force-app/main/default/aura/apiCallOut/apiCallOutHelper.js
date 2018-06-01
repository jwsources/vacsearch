({
    getResponse: function(component, query, location, distance, limit) {
        // create a server side action.
        var host = 'https://www.nationalevacaturebank.nl';     
        var action = component.get("c.getCalloutResponseContents");
       // set the url parameter for getCalloutResponseContents method (to use as endPoint) 
        action.setParams({
            "url": host + '/vacature/zoeken.json?query=' + query + '&location=' + location + '&distance=' + distance + '&page=1&limit=' + limit + '&sort=relevance'
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                // set the response(return Map <string,object>) to response attribute.      
                component.set("v.response", response.getReturnValue()); 
                component.set("v.show", "true");
            }
        });
 
        $A.enqueueAction(action);
    },
})