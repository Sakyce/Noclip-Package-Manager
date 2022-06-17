--> Add something in this dictionary if you need to import your package in another location
local Constants = {}
Constants.Locations = {
	["ReplicatedStorage"] = game:GetService("ReplicatedStorage"),
	["ServerStorage"] = game:GetService("ServerStorage"),
	["ReplicatedFirst"] = game:GetService("ReplicatedFirst"),
	["ServerScriptService"] = game:GetService("ServerScriptService"),
	["StarterGui"] = game:GetService("StarterGui"),
	["StarterPack"] = game:GetService("StarterPack"),
	["StarterCharacterScripts"] = game:GetService("StarterPlayer").StarterCharacterScripts,
	["StarterPlayerScripts"] = game:GetService("StarterPlayer").StarterPlayerScripts,
	["Workspace"] = game:GetService("Workspace"),
}
Constants.PackagesId = 9940916733 --> Asset id of the packages to be imported
Constants.PackagesName = "ExamplePackage" --> If the packages are found in ServerStorage, cancels the import and copy the package from there instead

local function ImportErrorHandler()
	--> Kick players and tell them that Roblox Servers are not working.
	local function Kick(Player:Player)
		Player:Kick("Roblox servers are not working and it's not the fault of the Experience developers. Please come back later once Roblox fixed their servers or try it again in a minute.")
	end
	game.Players.PlayerAdded:Connect(Kick)
	for _,Player in pairs(game:GetService("Players"):GetPlayers()) do
		Kick(Player)
	end
	--> Destroys everything in the workspace for no reason at all.
	for _,stuff in pairs(workspace:GetChildren()) do
		pcall(function() stuff:Destroy() end)
	end
end


--> If there is not already the packages in ServerStorage, get it from the Toolbox.
local function tryImport()
	
	local Timeout = 0
	local Success, Results = nil, nil
	while Timeout <= 3 do
		
		Timeout += 1
		Success, Results = pcall(function() 
			return game:GetService("ServerStorage"):FindFirstChild(Constants.PackagesName) or 
				game:GetService("InsertService"):LoadAsset(Constants.PackagesId):GetChildren()[1]:GetChildren() 
		end)
		if Success then
			break
		end
		
	end
	
	if not Success then
		ImportErrorHandler()
		if Results:find("HTTP 404") then
			error(Constants.PackagesId.." Roblox Servers returned 404, the asset is not in the Toolbox")
		end
		if Results:find("HTTP 403") then
			error(Constants.PackagesId.." Roblox Servers returned 403, the asset has been moderated or the asset doesn't belong to the Experience owner")
		end
		error(Results)
	end
	
	return Results
	
end

local ImportedPackages : {Instance} = tryImport()

--> Moves each packages to their Location, highest priority first
while #ImportedPackages > 0 do
	
	local highestPriority, packageToMove = 0, nil
	
	for index,Stuff in pairs(ImportedPackages) do
		assert(Stuff:GetAttribute("Priority"), "Package doesn't have any priority set")
		
		if Stuff:GetAttribute("Priority") > highestPriority then
			highestPriority = Stuff:GetAttribute("Priority")
			packageToMove = Stuff
		end
	end
	
	if packageToMove then
		assert(packageToMove:GetAttribute("Location"), ("No location set for %s"):format(packageToMove.Name))
		assert(Constants.Locations[ packageToMove:GetAttribute("Location") ], ("No location in constants has been set for %s"):format( packageToMove:GetAttribute("Location") ))
		
		packageToMove.Parent = Constants.Locations[ packageToMove:GetAttribute("Location") ]
		table.remove(ImportedPackages, table.find(ImportedPackages, packageToMove))
	end
	
end

game:SetAttribute("Packages_Imported", true)
return true
