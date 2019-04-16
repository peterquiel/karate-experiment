package com.github.peterquiel.karate.experiment

import com.intuit.karate.Runner
import org.junit.jupiter.api.Test

class CallFeatureFromJavaTest {

    @Test
    void "calling feature relative to class"() {
        def args = [parameter: "Mr. Pink"]

        def result = Runner.runFeature(getClass(), "java-api.feature", args, false)

        assert result.simpleJson == [foo: 'bar']
        assert result.hello == "Hello Mr. Pink"
    }

    @Test
    void "calling feature with classpath"() {
        def args = [parameter: "Mr. Pink"]

        def result = Runner.runFeature("classpath:com/github/peterquiel/karate/experiment/java-api.feature", args, false)

        assert result.simpleJson == [foo: 'bar']
        assert result.hello == "Hello Mr. Pink"
    }
}
