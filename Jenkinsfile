pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
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
                bat '''
                if not exist boot.asm exit /b 1
                docker run --rm -v "%cd%:/workspace" -w /workspace nikhilos-builder nasm -f bin boot.asm -o boot.bin
                if not exist boot.bin exit /b 1
                '''
            }
        }

        stage('Build Kernel') {
            steps {
                bat '''
                if not exist kernel.c exit /b 1
                if not exist kernel_entry.asm exit /b 1
                if not exist linker.ld exit /b 1

                docker run --rm -v "%cd%:/workspace" -w /workspace nikhilos-builder nasm -f elf32 kernel_entry.asm -o kernel_entry.o
                docker run --rm -v "%cd%:/workspace" -w /workspace nikhilos-builder gcc -m32 -ffreestanding -c kernel.c -o kernel.o
                docker run --rm -v "%cd%:/workspace" -w /workspace nikhilos-builder ld -m elf_i386 -T linker.ld -o kernel.bin kernel_entry.o kernel.o

                if not exist kernel.bin exit /b 1
                '''
            }
        }

        stage('Create OS Image') {
            steps {
                bat '''
                copy /b boot.bin+kernel.bin os-image.bin
                if not exist os-image.bin exit /b 1
                '''
            }
        }

        stage('Archive Image') {
            steps {
                archiveArtifacts artifacts: 'os-image.bin', fingerprint: true
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