package com.github.peterquiel.karate.experiment.hook

import com.intuit.karate.Results
import com.intuit.karate.Runner
import com.intuit.karate.core.ExecutionContext
import com.intuit.karate.core.ExecutionHook
import com.intuit.karate.core.Feature
import com.intuit.karate.core.FeatureResult
import com.intuit.karate.core.PerfEvent
import com.intuit.karate.core.Scenario
import com.intuit.karate.core.ScenarioContext
import com.intuit.karate.core.ScenarioResult
import com.intuit.karate.core.Step
import com.intuit.karate.core.StepResult
import com.intuit.karate.http.HttpRequest
import com.intuit.karate.http.HttpRequestBuilder
import com.intuit.karate.http.HttpResponse
import org.junit.jupiter.api.Test

class ExecutionHookExampleTest {

    @Test
    void "run with new Runner integration" () {
        Results result = Runner.path("classpath:com/github/peterquiel/karate/experiment/runfeaturesfromcode/execution-hook-example.feature")
                .hook(new KarateExecutionHockExample())
                .parallel(1)
        assert result.getFailCount() == 0
    }
}

class KarateExecutionHockExample implements ExecutionHook {

    @Override
    boolean beforeScenario(Scenario scenario, ScenarioContext context) {
        println "before scenario"
        return true
    }

    @Override
    void afterScenario(ScenarioResult result, ScenarioContext context) {
        println "after scenario"
    }

    @Override
    boolean beforeFeature(Feature feature, ExecutionContext context) {
        println "before feature"
        return true
    }

    @Override
    void afterFeature(FeatureResult result, ExecutionContext context) {
        println "after feature"
    }

    @Override
    void beforeAll(Results results) {
        println "before all"
    }

    @Override
    void afterAll(Results results) {
        println "after all"
    }

    @Override
    boolean beforeStep(Step step, ScenarioContext context) {
        println "before step"
        if (step.text.trim().matches(/$\s*assert\s+that.*^/)) {
            step.text = step.text.replace("that", "")
        }
        return true
    }

    @Override
    void afterStep(StepResult result, ScenarioContext context) {

        println "after step"
    }

    @Override
    String getPerfEventName(HttpRequestBuilder req, ScenarioContext context) {
        return null
    }

    @Override
    void reportPerfEvent(PerfEvent event) {

    }
}


