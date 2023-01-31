# An alternative to ROBLOX [PackageLinks](https://developer.roblox.com/en-us/articles/roblox-packages)

## Description
Download game packages from Roblox Marketplace, and put them directly in the game when it starts.
This script is made for Roblox Experiences that needs the same script over multiple Places.
**You don't need to Publish every Places when you update your package. Which is a good benefit when having a dozen of places!**

For testing purposes, put your packages folder inside ServerStorage so you don't have to upload it on the toolbox. 

> **Warning**:
> If the packages fails to import, the server closes. You can change the behavior in function ImportErrorHandler()

## Instructions
1. Put everything you need to import in a folder, use the [Attributes](https://developer.roblox.com/en-us/articles/instance-attributes) Priority and Location.
2. Publish it to Roblox (Right click and "Publish To Roblox"), you don't need to publish it to the MarketPlace
3. Put this Script into ServerScriptService
4. Set Constants.PackagesId to the id of your packages to import
5. Set Constants.PackagesName to the name of the root folder in your packages
5. In case scripts that starts before this script finish importing packages. Read "InsertThisInYourScripts" Module.
6. If you want to test your packages before saving it to Roblox, put the Folder in ServerStorage
	
> **Warning**:
> **ALWAYS BACKUP IN CASE ROBLOX DELETES THE MODEL FROM THE TOOLBOX**


## Why ?:
I was creating [Noclipped Reality](https://www.roblox.com/groups/10640198/Noclip-Games) until PackageLinks created [more](https://devforum.roblox.com/t/package-issues-cant-publish-or-get-latest/365867) [issues](https://devforum.roblox.com/t/autoupdate-packagelink-models-are-extremely-buggy-in-team-create/653562) [than](https://devforum.roblox.com/t/a-package-keeps-thinking-i-changed-it-when-i-didnt/434887) [solving](https://devforum.roblox.com/t/cant-update-roblox-packages-because-the-last-version-got-moderated/1443363).
Also, I didn't wanted to use solutions like Rojo, So I made this. 
