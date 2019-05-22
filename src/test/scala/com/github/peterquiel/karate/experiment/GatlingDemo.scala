package com.github.peterquiel.karate.experiment

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class GatlingDemo extends Simulation {


    val protocol = karateProtocol(
          "/myendpoint" -> Nil
      )

      val action = karateFeature("classpath:com/github/peterquiel/karate/experiment/gatling-demo.feature")

      setUp(
          scenario("simple-scenario")
              .exec(action)
              .inject(rampUsersPerSec(1) to 5 during (5 seconds))
              .protocols(protocol)
      )

}