
BadBoyConfig:RegisterEvent("ADDON_LOADED")
BadBoyConfig:SetScript("OnEvent", function(frame, evt, addon)
	if addon ~= "BadBoy_CCleaner" then return end
	if type(BADBOY_CCLEANER) ~= "table" then
		BADBOY_CCLEANER = {
			"anal",
			"rape",
		}
	end

	local Ambiguate, gsub, prevLineId, result, BADBOY_CCLEANER = Ambiguate, gsub, 0, nil, BADBOY_CCLEANER
	local CanComplainChat, UnitInRaid, UnitInParty, SocialQueueUtil_GetNameAndColor = CanComplainChat, UnitInRaid, UnitInParty, SocialQueueUtil_GetNameAndColor

	table.sort(BADBOY_CCLEANER)
	local text
	for i=1, #BADBOY_CCLEANER do
		if not text then
			text = BADBOY_CCLEANER[i]
		else
			text = text.."\n"..BADBOY_CCLEANER[i]
		end
	end
	BadBoyCCleanerEditBox:SetText(text or "")

	--main filtering function
	local filter = function(_,event,msg,player,_,_,_,flag,chanid,_,_,_,lineId,guid)
		if lineId == prevLineId then
			return result
		else
			prevLineId, result = lineId, nil
			local trimmedPlayer = Ambiguate(player, "none")
			if event == "CHAT_MSG_CHANNEL" and (chanid == 0 or type(chanid) ~= "number") then return end --Only scan official custom channels (gen/trade)
			local _, _, relationship = SocialQueueUtil_GetNameAndColor(guid)
			if not CanComplainChat(lineId) or UnitInRaid(trimmedPlayer) or UnitInParty(trimmedPlayer) or relationship or flag == "GM" or flag == "DEV" then return end
			local lowMsg = msg:lower() --lower all text
			for i=1, #BADBOY_CCLEANER do --scan DB for matches
				if lowMsg:find(BADBOY_CCLEANER[i], nil, true) then
					if BadBoyLog then BadBoyLog("CCleaner", event, trimmedPlayer, msg) end
					result = true
					return true --found a trigger, filter
				end
			end
		end
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)

	frame:SetScript("OnEvent", nil)
	frame:UnregisterEvent("ADDON_LOADED")
end)

