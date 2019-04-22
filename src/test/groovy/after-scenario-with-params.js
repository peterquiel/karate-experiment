function fn(info, someParameter) {
    karate.log('called after scenario:', info.scenarioName);
    karate.log('some parameter: ' + someParameter);
}