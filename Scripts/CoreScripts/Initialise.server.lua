--[[

	This script was made by AstrophsicaDev
	
	Script Name: Initialise
	Purpose: To set up and move essention Yar890Studio folders. Allows for better organisation
	when game runs on server.
--]]

-- //Global Variables\\ --
kitName = "Racing"
replicatedFolder = script.Parent.Replicated
serverFolder = script.Parent.Server
configurationFolder = script.Parent.Parent.Configuration
apiFolder = script.Parent.Parent.API

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: onStart
	Parameter: nil
	Return: nil
	
	Purpose: Runs on start and sets up Yar890 Studio folders, including dump. Also moves
	replicated folder and server folder that are children of this script.
--]]
function onStart()
	-- Replicated Yar890 Studio folder (General)
	local replicatedYar890StudioFolder = game.ReplicatedStorage:FindFirstChild("Yar890Studio")
	if not replicatedYar890StudioFolder then
		replicatedYar890StudioFolder = createFolder("Yar890Studio", game.ReplicatedStorage)
	end
	
	-- Server Yar890 Studio folder (General)
	local serverYar890StudioFolder = game.ServerScriptService:FindFirstChild("Yar890Studio")
	if not serverYar890StudioFolder then
		serverYar890StudioFolder = createFolder("Yar890Studio", game.ServerScriptService)
	end
	
	-- Server Yar890 Studio dump folder (General)
	local serverDumpFolder = serverYar890StudioFolder:FindFirstChild("Dump")
	if not serverDumpFolder then
		serverDumpFolder = createFolder("Dump", serverYar890StudioFolder)
	end
	
	-- Check is server kit folder already exist. Display warning if it does exists
	if serverYar890StudioFolder:FindFirstChild(kitName) then
		warn("Multiple server " .. kitName .. " kits detected. You should only have 1 " .. kitName .. " kit folder in Workspace.")
		apiFolder:Destroy();
		script:Destroy();
		return; -- Should be unreachable
	end
	
	-- Check is replicated kit folder already exist. Display warning if it does exists
	if replicatedYar890StudioFolder:FindFirstChild(kitName) then
		warn("Multiple replicated " .. kitName .. " kits detected. You should only have 1 " .. kitName .. " kit folder in Workspace.")
		apiFolder:Destroy();
		script:Destroy();
		return; -- Should be unreachable
	end
	
	-- Server racing kit configuration folder (Racing)
	local serverConfigurationFolder = createFolder("Configuration", serverFolder);
	configurationFolder.Kart.Parent = serverConfigurationFolder;
	configurationFolder.SafetyLight.Parent = serverConfigurationFolder;
	configurationFolder.TrackChange.Parent = serverConfigurationFolder;
	configurationFolder.KartSpawn.Parent = serverConfigurationFolder
	configurationFolder.Group.Parent = serverConfigurationFolder;
	configurationFolder:Destroy()
	
	-- Moved API folder to server folder
	apiFolder.Parent = serverFolder;
	
	-- Move kart to server storage
	local serverKart = serverConfigurationFolder.Kart.KartModel.Value;
	serverKart.Parent = game.ServerStorage
	
	-- Hide spawn locations
	local spawnLocationsFolder = serverFolder.Configuration.KartSpawn.SpawnFolder.Value
	if spawnLocationsFolder ~= nil then
		for _, spawnPart in pairs(spawnLocationsFolder:GetChildren())do
			spawnPart.Transparency = 1
			spawnPart.Arrow.Enabled = false
		end
	end
	
	-- Rename replicated folder to kit name (Racing)
	replicatedFolder.Parent = replicatedYar890StudioFolder
	replicatedFolder.Name = kitName
	
	-- Rename server folder to kit name (Racing)
	serverFolder.Parent = serverYar890StudioFolder
	serverFolder.Name = kitName
	
	script.Parent = serverFolder;
	
	enableScripts()
end



--[[
	Function Name: enableScripts
	Parameter: nil
	Return: nil
	
	Purpose: Enables any scripts that needs to be enabled after folders have been moved to the
	correct places. May not always be used.
--]]
function enableScripts()
	for _, componentFolder in pairs(serverFolder:GetChildren()) do
		local controllerScript = componentFolder:FindFirstChildWhichIsA("Script");
		if (controllerScript) then
			controllerScript.Disabled = false;
		end
	end
end



--[[
	Function Name: createFolder
	Parameter: String, Object
	Return: Folder
	
	Purpose: Creates folders and changes its parent and name based on parameters.
--]]
function createFolder(Name, Parent)
	local folder = Instance.new("Folder", Parent)
	folder.Name = Name
	return folder
end

------------------------------------------ Events ------------------------------------------
onStart()