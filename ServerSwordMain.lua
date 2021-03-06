--[[
	The main server-script Script that handles swords.
	Last updated: 2/12/2019
]]--
local Enabled,Handle,Con,Debris,Trail,TakeDamage=false,script.Parent:WaitForChild'Handle',game.ChildAdded.Connect,game:GetService'Debris',script.Parent:WaitForChild'Blade':WaitForChild'Trail'
local AI,t,Rng,Anims=Debris.AddItem,tick,Random.new()
Con(script.Parent.Equipped,function()
	if script.Parent.Parent:WaitForChild'Humanoid':GetState()==Enum.HumanoidStateType.Swimming then
		script.Parent.Parent:WaitForChild'Humanoid':UnequipTools()
		return
	end
	if not Anims then
		Anims={}
		local Humanoid=script.Parent.Parent:WaitForChild'Humanoid'
		local Tab=script:GetChildren()
		for Idx=1,#Tab do
			Anims[#Anims+1]=Humanoid:LoadAnimation(Tab[Idx])
		end
	end
end)
Con(script.Parent.Activated,function()
	if script.Parent.Parent:WaitForChild'Humanoid':GetState()==Enum.HumanoidStateType.Swimming then
		script.Parent.Parent:WaitForChild'Humanoid':UnequipTools()
		return
	end
	if Enabled then
		return
	end
	Enabled=true
	Anims[Rng:NextInteger(1,#Anims)]:Play()
	Trail.Enabled=true
	Handle:WaitForChild'Slice':Play()
	local Ev
	Ev=Con(Handle.Touched,function(Part)
		if not Part.Parent.Parent or Part:IsDescendantOf(script.Parent.Parent)then
			return
		end
		local Hum=Part.Parent:FindFirstChild'Humanoid'or Part.Parent.Parent:FindFirstChild'Humanoid'
		if Hum and Hum.Health>0 then
			Ev:Disconnect()
			if not TakeDamage then
				TakeDamage=Hum.TakeDamage
			end
			local Damage=Rng:NextInteger(1,8)
			local zZ=Instance.new'BillboardGui'
			zZ.Adornee=Hum.Parent:FindFirstChild'Head'
			zZ.Active = true
			zZ.StudsOffset = Vector3.new(0,5,0)
			zZ.Size = UDim2.new(0, 200, 0, 50)
			local xX = Instance.new'TextLabel'
			xX.Text = '-'..Damage
			xX.Active = true
			xX.BackgroundTransparency = 1
			xX.ClipsDescendants = true
			xX.TextColor3 = BrickColor.Red().Color
			xX.Font = Enum.Font.Fantasy
			xX.TextScaled = true
			xX.Size = UDim2.new(0, 200, 0, 50)
			xX.Parent=zZ
			zZ.Parent=Hum.Parent:FindFirstChild'Head'
			AI(Debris,zZ,1.25)
			TakeDamage(Hum,Damage)
			Handle:WaitForChild'Slash':Play()
		end
	end)
	wait(.85)
	Trail.Enabled=false
	if Ev and Ev.Connected then
		Ev:Disconnect()
	end
	wait(.25)
	Enabled=false
end)
