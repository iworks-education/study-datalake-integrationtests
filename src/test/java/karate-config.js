function() {    
  var env = karate.properties['karate.env'];
  karate.log('karate.env system property is:', env);
  
  if (!env) {
    env = 'local';
  }

  var config = {
    env: env,
	endpoint: 'http://localhost:3000',
	clientid: '4tlrem51smu8m3hg26deon9hoh',
	userpoolid: 'us-east-1_6qFmqyEYn',
	username : 'plarentis',
	password : '12345678'
  }
  
  if (env == 'dev') {
    // customize
    config.endpoint = 'https://44k9ld7lgi.execute-api.us-east-1.amazonaws.com/prod';
    config.clientid = '4tlrem51smu8m3hg26deon9hoh';
    config.userpoolid = 'us-east-1_6qFmqyEYn';
    
  } else if (env == 'prod') {
	config.endpoint = 'https://loywsxjqul.execute-api.us-east-1.amazonaws.com/prod';
    config.clientid = '260f3ba1m5g2s47t6clgsekvta';
    config.userpoolid = 'us-east-1_dyXftvbHn'
  }
  
  
  karate.configure('connectTimeout', 90000);
  karate.configure('readTimeout', 90000);
  return config;
}