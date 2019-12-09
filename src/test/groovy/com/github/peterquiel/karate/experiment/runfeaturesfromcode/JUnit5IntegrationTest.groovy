package com.github.peterquiel.karate.experiment.runfeaturesfromcode

import com.intuit.karate.junit5.Karate


class JUnit5IntegrationTest {

    @Karate.Test
    Karate "calling karate feature with JUnit5 integration"() {

        return Karate.karate("../karate-syntax-collection").relativeTo(getClass())
    }
}
