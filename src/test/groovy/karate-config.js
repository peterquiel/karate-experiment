function fn() {

    /**
     * This function is called for every scenario.
     * If you want to call a function only once across features and parallel threads?
     * Use karate.callSingle and see
     * https://github.com/intuit/karate/blob/master/karate-demo/src/test/java/karate-config.js
     */
    var env = karate.env; // get java system property 'karate.env'

    // get a system property via karate.properties['some.name']

    karate.log('karate.env system property was:', env);

    var config = {
        someDefaultConfig: "mr.pink"
    };

    if (!env) {
        env = 'dev'; // a custom 'intelligent' default
    }

    if (env === 'stage') {
        // over-ride only those that need to be
        config.someUrlBase = 'https://stage-host/v1/auth';
    } else if (env === 'e2e') {
        config.someUrlBase = 'https://e2e-host/v1/auth';
    }
    // don't waste time waiting for a connection or if servers don't respond within 5 seconds
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    return config;
}

