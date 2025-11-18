#!/bin/bash

set -e

echo "☕ Setting up Java development environment..."

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get script directory (dotfiles root)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
JAVA_TOOLS_DIR="$DOTFILES_DIR/java-tools"

info "Installing Java tools to: $JAVA_TOOLS_DIR"

# Check prerequisites
if ! command -v java &> /dev/null; then
    error "Java not found. Install JDK first!"
    exit 1
fi

if ! command -v mvn &> /dev/null; then
    warn "Maven not found. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install maven
    else
        sudo apt-get install -y maven
    fi
fi

if ! command -v npm &> /dev/null; then
    error "npm not found. Install Node.js first!"
    exit 1
fi

# Create java-tools directory
mkdir -p "$JAVA_TOOLS_DIR"

# 1. Java Debug Adapter
info "Installing java-debug..."
if [ ! -d "$JAVA_TOOLS_DIR/java-debug" ]; then
    cd "$JAVA_TOOLS_DIR"
    git clone https://github.com/microsoft/java-debug.git
    cd java-debug
    ./mvnw clean install
    info "java-debug installed ✓"
else
    info "java-debug already exists, updating..."
    cd "$JAVA_TOOLS_DIR/java-debug"
    git pull
    ./mvnw clean install
fi

# 2. vscode-java-test
info "Installing vscode-java-test..."
if [ ! -d "$JAVA_TOOLS_DIR/vscode-java-test" ]; then
    cd "$JAVA_TOOLS_DIR"
    git clone https://github.com/microsoft/vscode-java-test.git
    cd vscode-java-test
    npm install
    npm run build-plugin
    info "vscode-java-test installed ✓"
else
    info "vscode-java-test already exists, updating..."
    cd "$JAVA_TOOLS_DIR/vscode-java-test"
    git pull
    npm install
    npm run build-plugin
fi

# 3. Lombok
info "Downloading Lombok..."
if [ ! -f "$JAVA_TOOLS_DIR/lombok.jar" ]; then
    curl -L https://projectlombok.org/downloads/lombok.jar -o "$JAVA_TOOLS_DIR/lombok.jar"
    info "Lombok downloaded ✓"
else
    info "Lombok already exists ✓"
fi

# 4. Google Java Style
info "Downloading Google Java Style..."
if [ ! -f "$JAVA_TOOLS_DIR/eclipse-java-google-style.xml" ]; then
    curl -L https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml \
        -o "$JAVA_TOOLS_DIR/eclipse-java-google-style.xml"
    info "Google Java Style downloaded ✓"
else
    info "Google Java Style already exists ✓"
fi

# Summary
info ""
info "✨ Java development environment setup complete!"
info ""
info "📦 Installed in: $JAVA_TOOLS_DIR"
info "  - java-debug/"
info "  - vscode-java-test/"
info "  - lombok.jar"
info "  - eclipse-java-google-style.xml"
info ""
info "📝 Make sure your ftplugin/java.lua points to:"
info "   \$HOME/dotfiles/java-tools/"
info ""
info "💡 These paths are now part of your dotfiles!"
