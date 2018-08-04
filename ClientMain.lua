local UIS,Hum,Sprint=game:GetService'UserInputService',script.Parent:WaitForChild'Humanoid'
local Con,Event=UIS.InputBegan.Connect,game:GetService'ReplicatedStorage':WaitForChild'Obj'
local FS,Par=Event.FireServer,script.Parent
getfenv().script=Par:WaitForChild'Animate'
Con(UIS.InputBegan,function(Key,Gc)
	if Gc then
		return
	end
	if Key.UserInputType==Enum.UserInputType.Keyboard and Key.KeyCode==Enum.KeyCode.LeftControl and not Sprint and not Par:FindFirstChildOfClass'Tool'and Hum:GetState()~=Enum.HumanoidStateType.Freefall then
		Sprint=true
		Hum.WalkSpeed=26
		local Ev,Ev1,Ev2
		Ev=Con(UIS.InputEnded,function(Key)
			if Key.UserInputType==Enum.UserInputType.Keyboard and Key.KeyCode==Enum.KeyCode.LeftControl then
				Ev:Disconnect()
				Ev1:Disconnect()
				Ev2:Disconnect()
				Hum.WalkSpeed=16
				Sprint=false
			end
		end)
		Ev1=Con(Par.ChildAdded,function(Child)
			if Child:IsA'Tool'and Ev and Ev.Connected then
				Ev1:Disconnect()
				Ev2:Disconnect()
				Ev:Disconnect()
				Hum.WalkSpeed=16
				Sprint=false
			end
		end)
		Ev2=Con(Hum.StateChanged,function(Old,New)
			if New==Enum.HumanoidStateType.Freefall then
				Hum.WalkSpeed=16
			elseif Old==Enum.HumanoidStateType.Freefall and(New==Enum.HumanoidStateType.Landed or New==Enum.HumanoidStateType.Swimming)and Sprint then
				Hum.WalkSpeed=26
			end
		end)
	end
end)
local function Round(float,snap)
	local snap = tonumber(snap)or 1
	local float = tonumber(float)or 0
	return math.floor(float/snap+.5) * snap
end
local saveYPosition, lastYPosition, lastPosition, myRoot
local function DefineCharacterParts()
	local findRoot = Par:FindFirstChild'HumanoidRootPart'
	if findRoot then
		myRoot = findRoot
		lastPosition = Vector3.new(findRoot.Position.X, 0, findRoot.Position.Z)
		lastYPosition = findRoot.Position.Y
	end
end
local function PlayerIsGrounded()
	local startPosition = myRoot.Position
	local endPosition = startPosition - Vector3.new(0, 1, 0)
	local newRay = Ray.new(startPosition, (endPosition - startPosition).Unit * 5)
	return workspace:FindPartOnRay(newRay,Par)
end
local Deb
Con(game:GetService'RunService'.Heartbeat,function()
	if Par.Parent and myRoot and myRoot.Parent then
		local newPosition=Vector3.new(myRoot.Position.X, 0, myRoot.Position.Z)
		local newYPosition=myRoot.Position.Y
		local sideDifference=Round((newPosition-lastPosition).magnitude,.1)
		local yDifference=Round(newYPosition-lastYPosition, 0.1)
		if sideDifference<10 and yDifference<0 and not PlayerIsGrounded()then
			if not saveYPosition then
				saveYPosition = lastYPosition
			end
		elseif sideDifference<10 and saveYPosition then
			local totalFallDistance=saveYPosition-newYPosition
			if math.abs(totalFallDistance)>=15 and Hum:GetState()~=Enum.HumanoidStateType.Swimming and not Deb then
				Deb=true
				wait(.075)
				if Hum.FloorMaterial==Enum.Material.Air and totalFallDistance<30 then
					Deb=false
					return
				end
				FS(Event,math.min(Round(totalFallDistance,.5),Hum.MaxHealth*.9))
				wait(.1)
				Deb=false
			end
			saveYPosition = nil
		else
			saveYPosition = nil
		end
		lastPosition = newPosition
		lastYPosition = newYPosition
	else
		lastPosition = nil
		lastYPosition = nil
		saveYPosition = nil
		DefineCharacterParts()
	end
end)
