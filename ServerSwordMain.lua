--[[
	The main Script that handles swords.
	Last updated: 8/4/2018
]]--
local Enabled,Handle,mr,Con,Debris,Trail,TakeDamage=false,script.Parent:WaitForChild'Handle',math.random,game.ChildAdded.Connect,game:GetService'Debris',script.Parent:WaitForChild'Blade':WaitForChild'Trail'
local AI,Anims,mr,mrs,t=Debris.AddItem,{},math.random,math.randomseed,tick
Con(script.Parent.Equipped,function()
	if script.Parent.Parent:WaitForChild'Humanoid':GetState()==Enum.HumanoidStateType.Swimming then
		script.Parent.Parent:WaitForChild'Humanoid':UnequipTools()
		return
	end
	if #Anims==0 then
		local Humanoid=script.Parent.Parent:WaitForChild'Humanoid'
		for _,a in ipairs(script:GetChildren())do
			Anims[#Anims+1]=Humanoid:LoadAnimation(a)
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
	local Ev
	mrs(t())
	Anims[mr(1,#Anims)]:Play()
	Trail.Enabled=true
	Handle:WaitForChild'Slice':Play()
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
			local Damage=mr(1,8)
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
