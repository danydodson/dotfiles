# Managing Firefox Profiles

## Copy Essential Files

Optional Files

    storage folder: If you want to keep add-on customizations (this may not work 100% of the time).
    chrome folder: If you want to retain your interface customizations.

After turning off Firefox, copy the following files from your profile folder:

    places.sqlite: Contains bookmarks and history.
    cookies.sqlite: Stores login sessions.
    cert9.db + key4.db + logins.json: Holds your saved passwords.
    extension-preferences.json + extensions.json + extension-settings.json + extensions folder: These files keep track of your installed add-ons (but not their custom settings).
    search.json.mozlz4: Stores your search engine preferences.
    sessionCheckpoints.json + sessionstore.jsonlz4: Saves your currently open tabs.
    prefs.js: Contains your about:config settings.

## Create and Set Up a New Profile

Incompatibility Error

If Firefox opens with an incompatibility error after pasting the files, go to the new profile folder and move the compatibility.ini file somewhere else.

    Go to about:profiles in Firefox.
    Click on "Create a New Profile."
    Select a folder to store the new profile.
    Launch Firefox with the new profile.
    Go to about:support again and open the profile folder for the new profile.
    Turn off Firefox.
    Paste the files you copied earlier into the new profile folder.

## Final Step: Set as Default Profile

After ensuring everything works correctly, go back to about:profiles and set the newly created profile as the default. This will make it your main profile moving forward.
