--[[
	KaizenRep
	
	author: scottcreynolds (loganvi of illidan-US)
	
	Simple, lightweight adddon to change your rep bar to the last gained/lost faction. No configuration.
	
--]]
	
local f = CreateFrame("frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")

function f:ADDON_LOADED(event, addon)
	if addon:lower() ~= "kaizenrep" then return end
end

function f:CHAT_MSG_COMBAT_FACTION_CHANGE(event,arg1)
	faction = MatchReputationMessage(arg1)
	if faction ~= nil then
		SetWatchedFactionIndex(faction)
	end
end

function MatchReputationMessage(message)
	local factionIndex = 1
	repeat
		local name = GetFactionInfo(factionIndex)
		if name ~= nil and string.find(message,name) ~= nil then
			return factionIndex
		end
		factionIndex = factionIndex + 1
	until factionIndex > 200	
	return nil	
end