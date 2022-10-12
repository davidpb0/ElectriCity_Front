def appname = "Runner" //DON'T CHANGE THIS. This refers to the flutter 'Runner' target.


pipeline {
    agent any
    
    environment {
        PATH = "/Usarios/david/development/flutter/bin"
    }
    stages {
        stage ('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh "flutter test --coverage"
            }
        }
        stage('Run Analyzer') {
            steps {
                sh "dartanalyzer --options analysis_options.yaml ."
            }
        }

    }
}
