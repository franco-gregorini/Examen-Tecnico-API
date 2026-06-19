package config;

import com.intuit.karate.junit5.Karate;

public class Runner {
    
    @Karate.Test
    Karate runTest() {
        return Karate.run("classpath:features").tags("Api_Test");
    }
}
