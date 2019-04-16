package com.github.peterquiel.karate.experiment

import com.intuit.karate.junit5.Karate

class KarateSyntaxCollectionTest {

    @Karate.Test
    Karate "This is my first Karate Test"() {
        return new Karate().feature("karate-syntax-collection").relativeTo(getClass())
    }
}
