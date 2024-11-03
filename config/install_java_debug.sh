TEMP_DIR=$(mktemp -d)
git clone --depth 1 https://github.com/microsoft/java-debug "$TEMP_DIR"
cd "$TEMP_DIR"
./mvnw clean install
rm -rf "$TEMP_DIR"