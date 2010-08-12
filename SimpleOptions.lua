
do
	BadBoyConfig:RegisterEvent("PLAYER_LOGIN")
	BadBoyConfig:SetScript("OnEvent", function(frame)
		if type(BADBOY_CCLEANER) ~= "table" then
			BADBOY_CCLEANER = {
				"rape",
				"anal",
				"murloc",
			}
		end
		local text
		for i=1, #BADBOY_CCLEANER do
			if not text then
				text = BADBOY_CCLEANER[i]
			else
				text = text.."\n"..BADBOY_CCLEANER[i]
			end
		end
		BadBoyCCleanerEditBox:SetText(text)
		frame:SetScript("OnEvent", nil)
		frame:UnregisterEvent("PLAYER_LOGIN")
	end)

	BadBoyCCleanerConfigTitle:SetText("BadBoy_CCleaner @project-version@")

	local ccleanerNoIcons = CreateFrame("CheckButton", "BadBoyCCleanerNoIconButton", BadBoyConfig)
	ccleanerNoIcons:SetWidth(26)
	ccleanerNoIcons:SetHeight(26)
	ccleanerNoIcons:SetPoint("TOPLEFT", BadBoyLevelsEditBox, "BOTTOMLEFT", -10, -20)
	ccleanerNoIcons:SetScript("OnShow", function(frame)
		if BADBOY_NOICONS then
			frame:SetChecked(true)
		else
			frame:SetChecked(false)
		end
	end)
	ccleanerNoIcons:SetScript("OnClick", function(frame)
		local tick = frame:GetChecked()
		if tick then
			PlaySound("igMainMenuOptionCheckBoxOn")
			BADBOY_NOICONS = true
		else
			PlaySound("igMainMenuOptionCheckBoxOff")
			BADBOY_NOICONS = nil
		end
	end)

	ccleanerNoIcons:SetHitRectInsets(0, -200, 0, 0)

	ccleanerNoIcons:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	ccleanerNoIcons:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	ccleanerNoIcons:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	ccleanerNoIcons:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	local noIconsMsgText = ccleanerNoIcons:CreateFontString("BadBoyCCleanerNoIconButtonTitle", "ARTWORK", "GameFontHighlight")
	noIconsMsgText:SetPoint("LEFT", ccleanerNoIcons, "RIGHT", 0, 1)
	noIconsMsgText:SetText("Replace Raid Icons")

	local ccleanerInput = CreateFrame("EditBox", "BadBoyCCleanerInput", BadBoyConfig, "InputBoxTemplate")
	ccleanerInput:SetPoint("TOPLEFT", ccleanerNoIcons, "BOTTOMLEFT", 10, -5)
	ccleanerInput:SetAutoFocus(false)
	ccleanerInput:EnableMouse(true)
	ccleanerInput:SetWidth(250)
	ccleanerInput:SetHeight(20)
	ccleanerInput:SetMaxLetters(30)
	ccleanerInput:SetScript("OnEscapePressed", function(frame)
		frame:SetText("")
		frame:ClearFocus()
	end)
	ccleanerInput:SetScript("OnTextChanged", function(_, changed)
		if changed then
			local msg = (BadBoyCCleanerInput:GetText()):lower()
			BadBoyCCleanerInput:SetText(msg)
		end
	end)
	ccleanerInput:Show()

	local ccleanerButton = CreateFrame("Button", "BadBoyCCleanerButton", ccleanerInput, "UIPanelButtonTemplate")
	ccleanerButton:SetWidth(90)
	ccleanerButton:SetHeight(20)
	ccleanerButton:SetPoint("LEFT", ccleanerInput, "RIGHT")
	ccleanerButton:SetText(ADD.."/"..REMOVE)
	ccleanerButton:SetScript("OnClick", function(frame)
		BadBoyCCleanerInput:ClearFocus()
		--[[local t = BadBoyCCleanerInput:GetText()
		local found
		for i=1, #BADBOY_CCLEANER do
			if BADBOY_CCLEANER[i] == t then found = i end
		end
		if found then
			tremove(BADBOY_CCLEANER, found)
		else
			tinsert(BADBOY_CCLEANER, t)
		end
		local text
		for i=1, #BADBOY_CCLEANER do
			if not text then
				text = BADBOY_CCLEANER[i]
			else
				text = text.."\n"..BADBOY_CCLEANER[i]
			end
		end
		BadBoyCCleanerEditBox:SetText(text)]]
		BadBoyCCleanerInput:SetText("")
	end)
	ccleanerInput:SetScript("OnEnterPressed", function() BadBoyCCleanerButton:Click() end)

	local ccleanerScrollArea = CreateFrame("ScrollFrame", "BadBoyCCleanerConfigScroll", BadBoyConfig, "UIPanelScrollFrameTemplate")
	ccleanerScrollArea:SetPoint("TOPLEFT", ccleanerInput, "BOTTOMLEFT", 0, -7)
	ccleanerScrollArea:SetPoint("BOTTOMRIGHT", BadBoyConfig, "BOTTOMRIGHT", -30, 10)

	local ccleanerEditBox = CreateFrame("EditBox", "BadBoyCCleanerEditBox", BadBoyConfig)
	ccleanerEditBox:SetMultiLine(true)
	ccleanerEditBox:SetMaxLetters(99999)
	ccleanerEditBox:EnableMouse(false)
	ccleanerEditBox:SetAutoFocus(false)
	ccleanerEditBox:SetFontObject(ChatFontNormal)
	ccleanerEditBox:SetWidth(350)
	ccleanerEditBox:SetHeight(250)
	ccleanerEditBox:Show()

	ccleanerScrollArea:SetScrollChild(ccleanerEditBox)

	local ccleanerBackdrop = CreateFrame("Frame", "BadBoyCCleanerBackdrop", BadBoyConfig)
	ccleanerBackdrop:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = {left = 3, right = 3, top = 5, bottom = 3}}
	)
	ccleanerBackdrop:SetBackdropColor(0,0,0,1)
	ccleanerBackdrop:SetPoint("TOPLEFT", ccleanerInput, "BOTTOMLEFT", -5, 0)
	ccleanerBackdrop:SetPoint("BOTTOMRIGHT", BadBoyConfig, "BOTTOMRIGHT", -27, 5)
end

