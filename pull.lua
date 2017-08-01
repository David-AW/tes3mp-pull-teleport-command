Methods = {}

pullable = {}
pullableTimeLimit = 30 -- In seconds
pullableDistance = 12000 -- a cell is about 8000x8000 units so the Hypotenuse is ~11300 units.

Methods.ProcessPullCommand = function(pid, pid2)
	if pid2 ~= nil then
		if myMod.CheckPlayerValidity(pid, pid2) then
			
			local pid2 = tonumber(pid2)
			
			if pullable[pid2] ~= nil then
				
				if findDistance(pid, pid2) <= pullableDistance then
					myMod.TeleportToPlayer(pid2, pid2, pid)
					pullable[pid2] = nil
				else
					tes3mp.SendMessage(pid, "Target player is not in range to be pulled.\n", false)
				end

			else
				tes3mp.SendMessage(pid, "Target player has not requested to be pulled.\n", false)
			end
		end
	else
		if pullable[pid] == nil then
			timer = tes3mp.CreateTimerEx("pullTimerExpired", time.seconds(pullableTimeLimit), "i", pid)
			pullable[pid] = true
			tes3mp.SendMessage(pid, "You are able to be pulled to nearby players for "..pullableTimeLimit.." seconds.\n", false)
			tes3mp.StartTimer(timer)
			for i,p in pairs(Players) do
				if p.pid ~= pid then
					if findDistance(p.pid, pid) <= pullableDistance then
						tes3mp.SendMessage(p.pid, "Nearby player, "..Players[pid].accountName..", is able to be pulled to your location. pid:"..pid.."\n", false)
					end
				end
			end
		else
			tes3mp.SendMessage(pid, "You are already pullable.\n", false)
		end
	end
end

function findDistance(pid, pid2)

	local x1 = tes3mp.GetPosX(pid2)
	local x2 = tes3mp.GetPosX(pid)
	
	local z1 = tes3mp.GetPosZ(pid2)
	local z2 = tes3mp.GetPosZ(pid)
	
	return math.sqrt(math.pow(x2 - x1, 2) + math.pow(z2 - z1, 2))

end

function pullTimerExpired(pid)

	if pullable[pid] ~= nil then
		pullable[pid] = nil
		tes3mp.SendMessage(pid, "Pull timer expired.\n", false)
	end

end

return Methods
