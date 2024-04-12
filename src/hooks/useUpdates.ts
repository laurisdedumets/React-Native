import * as Updates from 'expo-updates';
import {useEffect} from 'react';
import {Alert} from 'react-native';

export const useUpdates = () => {
  const {isUpdateAvailable, isUpdatePending, downloadError} =
    Updates.useUpdates();

  // Handle checking for updates on app start.
  // This is done manually as the automatic check also downloads the update,
  // but we want this to be an opt-in feature for now.
  useEffect(() => {
    const checkForUpdates = async () => {
      await Updates.checkForUpdateAsync();
    };

    checkForUpdates();
  }, []);

  // Handle prompting the user for downloading an update if one is available.
  useEffect(() => {
    if (isUpdateAvailable) {
      Alert.alert(
        'Update Available',
        'An update is available. Would you like to download it?',
        [
          {
            text: 'No',
            onPress: () => {
              // Do nothing.
            },
          },
          {
            text: 'Yes',
            onPress: Updates.fetchUpdateAsync,
          },
        ],
      );
    }
  }, [isUpdateAvailable]);

  // Handle applying the update once it has been downloaded.
  useEffect(() => {
    if (isUpdatePending) {
      Alert.alert(
        'Update Ready',
        'The update is ready to be installed. Would you like to do it now?',
        [
          {
            text: 'No',
            onPress: () => {
              // Do nothing.
            },
          },
          {
            text: 'Yes',
            onPress: Updates.reloadAsync,
          },
        ],
      );
    }
  }, [isUpdatePending]);

  // Show a message if the update fails to download.
  useEffect(() => {
    if (downloadError) {
      Alert.alert('Update Error', downloadError.message);
    }
  }, [downloadError]);
};
