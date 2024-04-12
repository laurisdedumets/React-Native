# Create bundle.
expo export --experimental-bundle --output-dir dist

# Copy meta information about the update.
cp app.json dist && cp package.json dist

# Archive the bundle.
cd dist
zip -q update.zip -r ./*
cd -

# Upload the bundle.
curl --location --request POST 'http://localhost:3000/upload' \
--form "uri=@dist/update.zip" \
--header "project: react-native" \
--header "version: 1.0.0" \
--header "release-channel: main" \
--header "upload-key: abc123def456" \
--header "git-branch: $(git rev-parse --abbrev-ref HEAD)" \
--header "git-commit: $(git log --oneline -n 1)"
