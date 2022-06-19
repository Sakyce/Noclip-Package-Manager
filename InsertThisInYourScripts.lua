-- Put this code snippet at the start of your scripts, it can take up to two seconds to insert the packages.

--> Yield the script until packages are loaded
if not game:GetAttribute("Packages_Imported") then
	game:GetAttributeChangedSignal("Packages_Imported"):Wait()
end

--> Use this instead of local scripts because the game object isn't replicated
if not game.ReplicatedStorage:GetAttribute("Packages_Imported") then
	game.ReplicatedStorage:GetAttributeChangedSignal("Packages_Imported"):Wait()
end
