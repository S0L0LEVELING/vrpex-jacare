-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_taskbar",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chance = 0
local skillGap = 0
local activeTasks = 0
local taskInProcess = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENGUI
-----------------------------------------------------------------------------------------------------------------------------------------
function openGui(sentLength,taskID,chancesent,skillGapSent)
	SetNuiFocus(true,false)
	SendNUIMessage({ runProgress = true, Length = sentLength, Task = taskID, chance = chancesent, skillGap = skillGapSent })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGUI
-----------------------------------------------------------------------------------------------------------------------------------------
function updateGui(sentLength,taskID,chancesent,skillGapSent)
	SendNUIMessage({ runUpdate = true, Length = sentLength, Task = taskID, chance = chancesent, skillGap = skillGapSent })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEGUI
-----------------------------------------------------------------------------------------------------------------------------------------
function closeGui()
	SetNuiFocus(false,false)
	SendNUIMessage({ closeProgress = true })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENORMALGUI
-----------------------------------------------------------------------------------------------------------------------------------------
function closeNormalGui()
	SetNuiFocus(false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKEND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("taskEnd",function(data,cb)
	closeNormalGui()
	if (tonumber(data.taskResult) > chance) and tonumber(data.taskResult) < (chance + skillGap + 3) then
		activeTasks = 3
	else
		activeTasks = 2
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKBAR
-----------------------------------------------------------------------------------------------------------------------------------------
function taskBar(difficulty,skillGapSent)
	Citizen.Wait(100)

	skillGap = skillGapSent

	if skillGap < 5 then
		skillGap = 5
	end

	if taskInProcess then
		return false
	end

	chance = math.random(20,80)

	local length = math.ceil(difficulty * 1.0)

	taskInProcess = true
	local taskIdentifier = "taskid"..math.random(1000000)
	openGui(length,taskIdentifier,chance,skillGap)
	activeTasks = 1

	local maxcount = GetGameTimer() + length

	while activeTasks == 1 do
		Citizen.Wait(1)

		local curTime = GetGameTimer()
		if curTime > maxcount then
			activeTasks = 2
		end

		local updater = 100 - (((maxcount - curTime) / length) * 100)
		updater = math.min(100,updater)
		updateGui(updater,taskIdentifier,chance,skillGap)
	end

	closeGui()
	taskInProcess = false

	if activeTasks == 2 then
		return false
	else
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKONE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskOne()
	local finished = taskBar(1500,7)
	if finished then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKTWO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskTwo()
	local finished = taskBar(2000,7)
	if finished then
		local finished = taskBar(1500,7)
		if finished then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKTHREE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskThree()
	local finished = taskBar(2500,7)
	if finished then
		local finished = taskBar(2000,7)
		if finished then
			local finished = taskBar(1500,7)
			if finished then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKMECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskMechanic()
	local finished = taskBar(7500,7)
	if finished then
		local finished = taskBar(5000,7)
		if finished then
			local finished = taskBar(2500,7)
			if finished then
				local finished = taskBar(1000,7)
				if finished then
					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKFISHING
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskFishing()
	local finished = taskBar(20000,7)
	if finished then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskHandcuff()
	local finished = taskBar(1000,7)
	if finished then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKTHREE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskLockpick()
	local finished = taskBar(2500,7)
	if finished then
		local finished = taskBar(2000,7)
		if finished then
			local finished = taskBar(1500,7)
			if finished then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKTHREE
-----------------------------------------------------------------------------------------------------------------------------------------
function taskThree()
	local finished = taskBar(2500,7)
	if finished then
		local finished = taskBar(2000,7)
		if finished then
			local finished = taskBar(1500,7)
			if finished then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
function taskHomes()
	local finished = taskBar(4500,7)
	if finished then
		local finished = taskBar(3500,7)
		if finished then
			local finished = taskBar(2500,7)
			if finished then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASKDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.taskDoors()
	local finished = taskBar(500,7)
	if finished then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("taskThree",taskThree)
exports("taskHomes",taskHomes)