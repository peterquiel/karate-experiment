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

//        This does not work, because the file look up expects that the feature file resides next to the class file
//        This is true for maven, but gradle put all resource file into a separate resource folder.
//        Hence, this does not work and I have to use the `classpath:` lookup instead.
//        def result = Runner.runFeature(getClass(), "java-api.feature", args, false)

        def result = Runner.runFeature("classpath:com/github/peterquiel/karate/experiment/java-api.feature", args, false)

        assert result.simpleJson == [foo: 'bar']
        assert result.hello == "Hello Mr. Pink"
    }
}
