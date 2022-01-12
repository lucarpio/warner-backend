function fn() {
	// get system property 'karate.env'
	var env = karate.env;

	// Environment Default
	if (!env) {
		env = 'qa';
	}

	var config = {
		/* -------------------------- PATHS -------------------------- */
		path_notification: '/SetnotificationRequest',
		path_content_request: '/GetContentRequestEF',
		path_insert_request: '/InsertNewRequest'
	}

	/* -------------------------- SETTINGS -------------------------- */

	config.ambiente = karate.call('core/environment/config-' + env + '.js');

	karate.log('karate.env system property was:', env);

	return config;
}
