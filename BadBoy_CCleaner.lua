
local triggers = {
	"rape",
	"rectum",
	"anal",
	"inbed",
	"%[willy%]",
	"%[turd%]",
	"vaginal",
	"atthegaybar",
	"harry.*potter.*%[.*%]",
	"chucknorris",
	"murloc",
	"|cffff8000", --legendary color
}

local savedID, result = 0, nil
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", function(_,_,msg,_,_,_,_,_,chanid,_,_,_,id)
	if id == savedID then return result else savedID = id end --incase a message is sent more than once
	if chanid == 0 then result = nil return end --Only scan official custom channels (gen/trade)
	if not _G.CanComplainChat(id) then result = nil return end --Don't filter ourself
	msg = string.lower(msg) --lower all text
	msg = strreplace(msg, " ", "") --Remove spaces
	for k, v in ipairs(triggers) do
		if msg:find(v) then
			result = true
			return true --found a trigger, filter
		end
	end
	result = nil
end)

