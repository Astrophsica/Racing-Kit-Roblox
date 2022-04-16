-- Source: https://developer.roblox.com/en-us/articles/building-carkit-1
-- Source: https://developer.roblox.com/en-us/api-reference/function/RunService/BindToRenderStep
local RunService = game:GetService("RunService")

local vehicle = script:WaitForChild("KartObject").Value;

local vehicleSeat = vehicle.VehicleSeat;

local sound = vehicle.Chassis.Engine.Sound;

local hoodHinge = vehicle.Chassis.Hood.HingeConstraint;

local tires = vehicle.Wheels;

local motorFR = tires.WheelFR:FindFirstChildWhichIsA("CylindricalConstraint", true)
local motorFL = tires.WheelFL:FindFirstChildWhichIsA("CylindricalConstraint", true)
local motorBR = tires.WheelBR:FindFirstChildWhichIsA("CylindricalConstraint", true)
local motorBL = tires.WheelBL:FindFirstChildWhichIsA("CylindricalConstraint", true)

local springFR = tires.WheelFR:FindFirstChildWhichIsA("SpringConstraint", true)
local springFL = tires.WheelFL:FindFirstChildWhichIsA("SpringConstraint", true)
local springBR = tires.WheelBR:FindFirstChildWhichIsA("SpringConstraint", true)
local springBL = tires.WheelBL:FindFirstChildWhichIsA("SpringConstraint", true)

local wheelHingeR = tires.WheelFR:FindFirstChildWhichIsA("HingeConstraint", true)
local wheelHingeL = tires.WheelFL:FindFirstChildWhichIsA("HingeConstraint", true)

local configuration = script:WaitForChild("Configuration");

-- TUNING VALUES
----------------------------------------
-- Factor of torque applied to get the wheels spinning
-- Larger number generally means faster acceleration
local TORQUE = configuration:WaitForChild("Torque").Value;

-- Car max speed
local MAX_SPEED = vehicleSeat.MaxSpeed;

-- Factor of torque applied to change the wheel direction
-- Larger number generally means faster braking
local BRAKING_TORQUE = configuration:WaitForChild("BrakingTorque").Value;

-- Max angle the wheels will reach when turning
-- Higher number means sharper turning, but too high means the wheels might hit the car base
local MAX_TURN_ANGLE = configuration:WaitForChild("MaxTurnAngle").Value;

-- Reverse torque (Torque when reversing)
local REVERSE_TORQUE = configuration:WaitForChild("ReverseTorque").Value;
local REVERSE_MAX_SPEED = configuration:WaitForChild("ReverseMaxSpeed").Value;
----------------------------------------


-- HELPER FUNCTIONS
----------------------------------------
-- Set the "MotorMaxTorque" property on all of the CylindricalConstraint motors
local function setMotorTorque(torque)
	motorFR.MotorMaxTorque = torque
	motorFL.MotorMaxTorque = torque
	motorBR.MotorMaxTorque = torque
	motorBL.MotorMaxTorque = torque
end

-- Set the "AngularVelocity" property on all of the CylindricalConstraint motors
local function setMotorVelocity(vel)
	motorFL.AngularVelocity = vel
	motorBL.AngularVelocity = vel
	-- Motors on the right side are facing the opposite direction, so negative velocity must be used
	motorFR.AngularVelocity = -vel
	motorBR.AngularVelocity = -vel
end

-- Calculate the average linear velocity of the car based on the rate at which all wheels are spinning
local function getAverageVelocity()
	local vFR = -motorFR.Attachment1.WorldAxis:Dot(motorFR.Attachment1.Parent.RotVelocity)
	local vRR = -motorBR.Attachment1.WorldAxis:Dot(motorBR.Attachment1.Parent.RotVelocity)
	local vFL = motorFL.Attachment1.WorldAxis:Dot(motorFL.Attachment1.Parent.RotVelocity)
	local vRL = motorBL.Attachment1.WorldAxis:Dot(motorBL.Attachment1.Parent.RotVelocity)
	return 0.25 * ( vFR + vFL + vRR + vRL )
end

local function getAverageSteer()
	return (wheelHingeR.CurrentAngle + wheelHingeL.CurrentAngle) / 2;
end

-- Unbinds render step
local function onVehicleSeatChanged(pProperty)
	if (pProperty == "Occupant") then
		if (vehicleSeat.Occupant == nil) then
			local success, message = pcall(function() 
				RunService:UnbindFromRenderStep("DriveLoop") 
			end)
			script:Destroy();
		end
	end
end



-- DRIVE LOOP
----------------------------------------
local function OnRenderStep()
	-- Get current speed based on vehicle seat
	local currentSpeed = vehicle.PrimaryPart.Velocity.Magnitude;
	
	-- Update max speed
	MAX_SPEED = vehicleSeat.MaxSpeed

	-- Input values taken from the VehicleSeat
	local steerFloat = vehicleSeat.SteerFloat  -- Forward and backward direction, between -1 and 1
	local throttle = vehicleSeat.ThrottleFloat  -- Left and right direction, between -1 and 1

	-- Convert "steerFloat" to an angle for the HingeConstraint servos
	local turnAngle = steerFloat * MAX_TURN_ANGLE
	wheelHingeR.TargetAngle = turnAngle
	wheelHingeL.TargetAngle = turnAngle
	
	-- Set steering wheel angle
	local steerAngle = getAverageSteer();
	local steerPecentage = steerAngle / MAX_TURN_ANGLE;
	hoodHinge.TargetAngle = -(steerPecentage * hoodHinge.UpperAngle);

	-- Apply torque to the CylindricalConstraint motors depending on our throttle input and the current speed of the car
	local currentVel = getAverageVelocity()
	local targetVel = 0
	local motorTorque = 0
	
	-- Cap speed
	if (math.floor(currentSpeed) > MAX_SPEED) then
		if (currentVel >= 0) then
			-- Force braking
			motorTorque = BRAKING_TORQUE * -1 * -1;
		else
			-- Force accelaration. Torque reduced to 1/2 its value.
			motorTorque = (TORQUE / 2) * 1 * 1;
			targetVel = math.sign(throttle) * 10000;  -- Arbitrary large number
		end
		
	-- Idle
	elseif MAX_SPEED == 0 or math.abs(throttle) < 0.1 or math.floor(currentSpeed) == MAX_SPEED then
		motorTorque = 10;
		
	-- Accelerating
	elseif (throttle * currentVel) > 0 then
		
		if (throttle > 0) then
			-- Reduce torque with speed (if torque was constant, there would be a jerk reaching the target velocity)
			-- This also produces a reduction in speed when turning
			local r = math.abs(currentVel) / (MAX_SPEED + (MAX_SPEED * 0.3));
	
			-- Torque should be more sensitive to input at low throttle than high, so square the "throttle" value
			motorTorque = math.exp( - 3 * r * r ) * TORQUE * throttle * throttle;
			targetVel = math.sign(throttle) * 10000;  -- Arbitrary large number
		else
			-- This also produces a reduction in speed when turning
			local r = math.abs(currentVel) / (REVERSE_MAX_SPEED + (REVERSE_MAX_SPEED * 0.3));
	
			-- Torque should be more sensitive to input at low throttle than high, so square the "throttle" value
			motorTorque = math.exp( - 3 * r * r ) * REVERSE_TORQUE * throttle * throttle;
			targetVel = math.sign(throttle) * 10000;  -- Arbitrary large number
		end
		
	-- Braking
	else
		motorTorque = BRAKING_TORQUE * throttle * throttle;
	end

	
	if throttle < 0 then
		for _, light in pairs(vehicle.Chassis.Lights.BrakeLights:GetChildren())do
			light.Material = Enum.Material.Neon;
		end	
	else
		for _, light in pairs(vehicle.Chassis.Lights.BrakeLights:GetChildren())do
			light.Material = Enum.Material.Glass;
		end	
	end

	-- Use helper functions to apply torque and target velocity to all motors
	setMotorTorque(motorTorque);
	setMotorVelocity(targetVel);
	wait();
end
     
-- Bind the function (Process after input)
RunService:BindToRenderStep("DriveLoop", (Enum.RenderPriority.Input.Value) + 1, OnRenderStep);
vehicleSeat.Changed:Connect(onVehicleSeatChanged);

