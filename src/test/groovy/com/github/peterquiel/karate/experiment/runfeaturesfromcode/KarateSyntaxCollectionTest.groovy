package com.github.peterquiel.karate.experiment.runfeaturesfromcode

import com.intuit.karate.junit5.Karate


class KarateSyntaxCollectionTest {

    @Karate.Test
    Karate "This is my first Karate Test"() {

        println "here it comes"
        println System.properties.kick_my_ass;

        return new Karate().feature("../karate-syntax-collection").relativeTo(getClass())
    }
}
