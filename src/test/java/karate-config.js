function() {    
  var env = karate.properties['karate.env']; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
//  if (!env) {
//    env = 'dev';
//  }
  var config = {
    env: env,
	endpoint: 'http://localhost:3000',	
  }
  if (env == 'dev') {
    // customize
    config.endpoint = 'https://44k9ld7lgi.execute-api.us-east-1.amazonaws.com/prod'
  } else if (env == 'e2e') {
    // customize
  }
  karate.configure('connectTimeout', 90000);
  karate.configure('readTimeout', 90000);
  return config;
}