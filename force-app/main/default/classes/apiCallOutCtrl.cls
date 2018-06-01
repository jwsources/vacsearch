public class apiCallOutCtrl {
       
	// Pass in the endpoint to be used using the string url
	@AuraEnabled
	public static Map < string, object > getCalloutResponseContents(String url) {
 
		// Instantiate a new http object
		Http h = new Http();
 
		// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
		HttpRequest req = new HttpRequest();
		req.setEndpoint(url);
		req.setMethod('GET');
        req.setTimeout(120000);
        
        // Configure standard headers
        req.setHeader('Accept', '*/*');
        req.setHeader('Cookie', 'policy=accepted');

        // This tells the API that we are sending and receiving the data as a JSON object 
        req.setHeader('Content-Type', 'application/json');
        
        // Send the request, and return a response
        HttpResponse res = h.send(req);
            
        // check response 
        //if ((res.getStatusCode() == 200 || res.getStatusCode() == 201) && res.getBody() != null && res.getBody() != null) {
                System.debug('response:--> ' + res.getBody());
        
		// Deserialize the JSON string into collections of primitive data types.
		Map < String, Object > returnMap = (Map < String, Object > ) JSON.deserializeUntyped(res.getBody());
		system.debug('returnMap-->' + returnMap);
        if (returnMap.containsKey('result')) {
        	// The deserialized response contains the expected key!
            system.debug('Success!');
        }
        
        Map < String, Object > resultMap = (Map <String, Object > ) returnMap.get('result');
        system.debug('resultMap-->' + resultMap);
        List < object > joblist = new List < object >();
               for(String s:resultMap.keyset()){
                  object t=(object)resultMap.get(s);
                   joblist.add(t);
               }
        //system.debug('jobList-->' + jobList);
        Map < String, Object > jobMap = new Map < String, Object > ();	
        jobMap.put('Jobs', joblist.get(0));
        jobMap.put('Total', joblist.get(2));
        List < Object > jobs = ( List < Object > ) jobMap.get('Jobs');
        jobMap.remove('Jobs');
        Integer count = 0;
        for ( Object job : jobs ){
            jobmap.put('Job' + count, job);
            Map<String, Object> jobdetail = (Map<String, Object>)job;
            jobMap.put('Job'+ count + 'Title',jobdetail.get('title'));
            jobMap.put('Job'+ count + 'Url', 'https://www.nationalevacaturebank.nl' + jobdetail.get('detailUrl'));
         	Map < String, Object > company = (Map <String, Object > ) jobdetail.get('company');
            jobMap.put('Job'+ count + 'Company', company.get('name'));
            jobMap.put('Job'+ count + 'Details', jobdetail.get('description'));         
        	//System.debug('Jobdesc-->' + jobMap.get('Job' + count + 'Details'));
            count++;
    	}

        system.debug('jobMap-->' + jobMap);
       
		return jobMap;
	}
}