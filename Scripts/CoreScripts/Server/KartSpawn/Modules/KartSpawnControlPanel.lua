--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: ControlModule
	Last Updated: 22/02/2021
	Purpose: Spawn karts at spawn location
--]]

----------------------------------------- Variables -----------------------------------------
-- Modules
local ControlPanel = require(script.Parent.Parent.Parent.Misc.Modules.ControlPanel);
local KartSpawnControlPanel = {}

-- OOP Set up
KartSpawnControlPanel.__index = KartSpawnControlPanel;
setmetatable(KartSpawnControlPanel, ControlPanel) -- Inheritence

-- Kart Inbound
local mKartInbound = script.Parent.Parent.Parent.Kart.Inbound

-- Configurations
local mConfiguration = script.Parent.Parent.Parent:WaitForChild("Configuration");
local mKart = mConfiguration.Kart.KartModel.Value;
local mSpawnLocations = mConfiguration.KartSpawn.SpawnFolder.Value;

-- Group Info
local mGroupConfiguration = mConfiguration:WaitForChild("Group");
local mGroupID = mGroupConfiguration:WaitForChild("GroupID").Value;
local mRankID = mGroupConfiguration:WaitForChild("RankID").Value;

-- Misc
local mOutboundFolder = script.Parent.Parent.Outbound;

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: ControlModule.new
	Parameters: Model
	Return: Array (ControlModule Object)
	
	Purpose: Create new instance of ControlModel and stores Control Module info.
--]]
function KartSpawnControlPanel.new(pControlPanelModel)
	local newKartSpawnControlPanel = ControlPanel.new(pControlPanelModel);
	setmetatable(newKartSpawnControlPanel, KartSpawnControlPanel);
	
	return newKartSpawnControlPanel;
end



--[[
	Function Name: SpawnKarts
	Parameter: Player
	Return: Nil
	
	Purpose: Spawn karts at spawn location.
--]]
function SpawnKarts()
	mKartInbound.DeleteKart:Fire(nil);
			
	for _, spawnLocation in pairs(mSpawnLocations:GetChildren()) do
		local clonedKart = mKart:Clone();
		clonedKart.Parent = game.Workspace;
		clonedKart:SetPrimaryPartCFrame(spawnLocation.CFrame)
		mKartInbound.AddKart:Fire(clonedKart);
	end
end



--[[
	Function Name: OnButtonClick
	Parameter: Player
	Return: Nil
	
	Purpose: Spawn karts on button click.
--]]
function KartSpawnControlPanel:OnButtonClick(pPlayer)
	if (pPlayer:GetRankInGroup(mGroupID) >= mRankID) then
		SpawnKarts();
		mOutboundFolder.KartSpawned:Fire(pPlayer);
	end
end


--[[
	Function Name: ControlPanelSetUp
	Parameter: Object 
	Return: nil
	
	Purpose: Set up click detector for button and spawn/respawn karts
--]]
function KartSpawnControlPanel:ControlPanelSetUp()
	-- Error checking spawn locations config
	if mSpawnLocations == nil then
		error("Yar890 Studio Racing Kit: Spawn Location folder not set. Set spawn location folder in Configuration > KartSpawn > SpawnFolder")
	end
	
	-- Error checking kart model config
	if mKart == nil then
		error("Yar890 Studio Racing Kit: KartModel value not set. Set KartModel value in Configutation > Kart > KartModel")
	end
	
	-- Loop through buttons
	for _, button in ipairs(self.mButtonsModel:GetChildren()) do
		if button:IsA("BasePart") then
			local clickDetector = Instance.new("ClickDetector", button)
			local OnButtonClickEvent = clickDetector.MouseClick:Connect(function(pPlayer)
				self:OnButtonClick(pPlayer, button.Name) 
			end);
			table.insert(self.mConnections, OnButtonClickEvent);
		end
	end
end



return KartSpawnControlPanel
