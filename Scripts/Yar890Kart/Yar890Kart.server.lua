--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Script Name: Yar890Kart
	Last Updated: 31/08/2020
	Purpose: To give drive script to client and flip kart
--]]

----------------------------------------- Variables -----------------------------------------
-- Services
local mDebrisService = game:GetService("Debris");

-- Objects
local mVehicle = script.Parent;
local mVehicleSeat = mVehicle:WaitForChild("VehicleSeat");
local mFlipPart = mVehicle:WaitForChild("Flip");
local mClickDetector = mFlipPart:WaitForChild("ClickDetector");
local mDriveScript = script:WaitForChild("DriveScript");
local mKartObjectValue = mDriveScript:WaitForChild("KartObject");
local mConfiguration = mDriveScript:WaitForChild("Configuration");

-- Sound
local mSoundDeamplifier = mConfiguration:WaitForChild("SoundDeamplifier").Value;
local mEngineSound = mVehicle.Chassis.Engine.Sound;
local mEngineVolume = mEngineSound.Volume;
local mEngineSoundId = mEngineSound.SoundId;

-- Misc
local mVehicleOccupied = nil;

------------------------------------------ Methods ------------------------------------------
--[[
	Function Name: OnPlayerAddedToKart
	Parameters: Player
	Return: Nil
	
	Purpose: Sets network ownership and clones driver script to player.
--]]
function OnPlayerAddedToKart(pPlayer)
	mVehicleSeat:SetNetworkOwner(pPlayer)
	local newDriveScript = mDriveScript:Clone();
	newDriveScript.Parent = pPlayer:WaitForChild("PlayerGui");
	mVehicleOccupied = pPlayer;
	
	StartEngineNoise();
end



--[[
	Function Name: OnPlayerRemovedFromKart
	Parameters: Nil
	Return: Nil
	
	Purpose: Sets network ownership back to auto.
--]]
function OnPlayerRemovedFromKart()
	mVehicleSeat:SetNetworkOwnershipAuto();
	mVehicleOccupied = nil;
end



--[[
	Function Name: OnFlipClickDetectorClick
	Parameters: Nil
	Return: Nil
	
	Purpose: Flip kart on flip button click.
--]]
function OnFlipClickDetectorClick()
	local Gyro = Instance.new("BodyGyro");
	Gyro.Parent = mVehicleSeat;
	mDebrisService:AddItem(Gyro, 3);
end



--[[
	Function Name: OnVehicleSeatChanged
	Parameters: String
	Return: Nil
	
	Purpose: On vehicle seat changed, check if occupant has entered or left vehicle seat.
--]]
function OnVehicleSeatChanged(pProperty)
	if pProperty == "Occupant" then
		local humanoid = mVehicleSeat.Occupant
		if humanoid then
			local player = game:GetService("Players"):GetPlayerFromCharacter(humanoid.Parent)
			if player then
				OnPlayerAddedToKart(player);
			end
		else
			OnPlayerRemovedFromKart();
		end
	end
end



--[[
	Function Name: StartEngineNoise
	Parameters: Nil
	Return: Nil
	
	Purpose: Starts engine noise loop until vehicle occupied removed
--]]
function StartEngineNoise()
	spawn(function()
		mEngineSound:Play();
		
		while (mVehicleOccupied) do
			local vehicleSpeed = mVehicle.PrimaryPart.Velocity.Magnitude;
			mEngineSound.PlaybackSpeed = vehicleSpeed / mSoundDeamplifier;
			wait();
		end
		
		mEngineSound:Stop();
	end)
end

------------------------------------------ Events ------------------------------------------
mVehicleSeat.Changed:Connect(OnVehicleSeatChanged);
mClickDetector.MouseClick:Connect(OnFlipClickDetectorClick);



