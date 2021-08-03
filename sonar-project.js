const sonarqubeScanner = require('sonarqube-scanner');

sonarqubeScanner({
  serverUrl: 'http://3.109.3.64:9000/',
       options : {
	    'sonar.projectDescription': 'This is a sample Node JS application',
	    'sonar.projectName': 'Sample Node JS Application',
	    'sonar.projectKey':'SampleNodeJs',
	    'sonar.login': '54b37cd8a347eaae59f3aa1ec1ebe8909ce3b97a',
            'sonar.projectVersion':'1.0',
	    'sonar.language':'js',
            'sonar.sourceEncoding':'UTF-8',
            'sonar.sources': '.',
	  //'sonar.tests': 'specs',
          //'sonar.inclusions' : 'src/**'
       },
}, () => {});
