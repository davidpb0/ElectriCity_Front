pipeline {
    agent any
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
        environment {
            PATH = "/Usarios/david/development/flutter/bin"
        }
    }
}
