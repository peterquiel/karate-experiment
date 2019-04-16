package com.github.peterquiel.karate.pbt

import com.intuit.karate.Runner
import net.jqwik.api.ForAll
import net.jqwik.api.Property
import net.jqwik.api.constraints.AlphaChars
import net.jqwik.api.constraints.NotEmpty
import org.slf4j.LoggerFactory

class KaratePropertyBasedTest {

    def logger = LoggerFactory.getLogger(getClass())

    @Property(tries = 20)
    void "first try to combine karate with property based testing"(@ForAll @NotEmpty String postBody) {

        def featurePath = "classpath:${getClass().package.name.replaceAll(/\./,'/')}/property-based.feature"
        logger.info("Using '$featurePath' for test case")

        def args = [postBody : postBody]
        def result = Runner.runFeature(  featurePath, args, false)

        assert result
    }

}
