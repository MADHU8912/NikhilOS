pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_USERNAME/NikhilOS.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t nikhilos-builder .'
            }
        }

        stage('Build Bootloader') {
            steps {
                bat 'docker run --rm -v "%cd%":/workspace -w /workspace nikhilos-builder nasm -f bin boot.asm -o boot.bin'
            }
        }

        stage('Build Kernel') {
            steps {
                bat 'docker run --rm -v "%cd%":/workspace -w /workspace nikhilos-builder gcc -m32 -ffreestanding -c kernel.c -o kernel.o'
                bat 'docker run --rm -v "%cd%":/workspace -w /workspace nikhilos-builder nasm -f elf32 kernel_entry.asm -o kernel_entry.o'
                bat 'docker run --rm -v "%cd%":/workspace -w /workspace nikhilos-builder ld -m elf_i386 -T linker.ld -o kernel.bin kernel_entry.o kernel.o --oformat binary'
            }
        }

        stage('Create OS Image') {
            steps {
                bat 'copy /b boot.bin + kernel.bin os-image.bin'
            }
        }

        stage('Archive Image') {
            steps {
                archiveArtifacts artifacts: 'os-image.bin', fingerprint: true
            }
        }
    }
}