# Define the update key to make the updates distinguishable.
UPDATE_KEY=$(date +%s)

# Create bundle.
npx expo export --output-dir dist/$UPDATE_KEY

# Add Expo configuration.
node exportClientExpoConfig.js > dist/$UPDATE_KEY/expoConfig.json

# Zip the bundle.
cd dist
zip update.zip -r ./$UPDATE_KEY

# Upload the bundle as a Base64 encoded string of the ZIP file.
base64 -i update.zip | curl --location 'http://localhost:3000/upload' \
--header 'expo-app-name: react-native' \
--header 'expo-release-channel: main' \
--header 'expo-runtime-version: 1.0.0' \
--header 'Content-Type: text/plain' \
--data @-

# Clean up.
rm -rf update.zip ./$UPDATE_KEY
