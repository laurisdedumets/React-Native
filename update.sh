# Define the update key to make the updates distinguishable.
UPDATE_KEY=$(date +%s)

# Create bundle.
npx expo export --output-dir dist/$UPDATE_KEY

# Add Expo configuration.
node exportClientExpoConfig.js > dist/$UPDATE_KEY/expoConfig.json
