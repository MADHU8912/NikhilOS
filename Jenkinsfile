pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Checkout') {
            steps {
                bat 'dir'
                echo 'Source checked successfully'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t nikhilos-builder .'
            }
        }

        stage('Build Bootloader') {
            steps {
                bat 'if not exist bootloader exit /b 1'
                bat 'echo Bootloader build step running'
                bat 'dir bootloader'
            }
        }

        stage('Build Kernel') {
            steps {
                bat 'if not exist kernel exit /b 1'
                bat 'echo Kernel build step running'
                bat 'dir kernel'
            }
        }

        stage('Create OS Image') {
            steps {
                bat 'echo Creating OS image...'
                bat 'mkdir output 2>nul'
                bat 'echo dummy> output\\nikhilos.img'
            }
        }

        stage('Archive Image') {
            steps {
                archiveArtifacts artifacts: 'output/*.img', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Build completed successfully'
        }
        failure {
            echo 'Build failed. Check the failed stage console output.'
        }
    }
}