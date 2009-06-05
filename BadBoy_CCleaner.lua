local ipairs = _G.ipairs
local fnd = _G.string.find
local lower = _G.string.lower

local triggers = {
	"%[.*%].*rectum",
	"rectum.*%[.*%]",
	"%[.*%].*anal",
	"anal.*%[.*%]",
}

local oldmsg, savedID, result = "", 0, nil
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", function(_,_,msg,_,_,_,_,_,chanid,_,_,_,id)
	if id == savedID then return result else savedID = id end --incase a message is sent more than once
	if chanid == 0 then result = nil return end --Only scan official custom channels (gen/trade)
	if not _G.CanComplainChat(id) then result = nil return end --Don't filter ourself
	msg = lower(msg) --lower all text
	for k, v in ipairs(triggers) do
		if fnd(msg, v) then
			result = true
			return true --found a trigger, filter
		end
	end
	if msg == oldmsg then
		result = true
		return true
	else
		oldmsg = msg
	end
	result = nil
end)

