GrannoAddon = LibStub("AceAddon-3.0"):NewAddon("GrannoAddon", "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0",
    "AceHook-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")



GrannoAddon.options = {
    type = "group",
    name = "Granno Addon",
    handler = GrannoAddon,
    args = {
        classBar = {
            order = 1,
            type = "toggle",
            name = "Hide ClassBar",
            desc = "Hide ClassBar like Holy Power, Combo Points, etc. (Clicking will reload ui)",
            get = function(info) return GrannoAddon.db.profile.classBar end,
            set = function(info, value) GrannoAddon.db.profile.classBar = value end,
        },
        totemBar = {
            order = 2,
            type = "toggle",
            name = "Hide TotemBar",
            desc = "Hide TotemBar",
            get = function(info) return GrannoAddon.db.profile.totemBar end,
            set = function(info, value) GrannoAddon.db.profile.totemBar = value end,
        },

        darkness = {
            order = 3,
            type = "range",
            name = "Darkness",
            desc = "Determines how dark the ui is, GrannoAddon.db.profile.darkness is the darkest, 1 is the lightest",
            get = function(info) return GrannoAddon.db.profile.darkness end,
            set = function(info, value) GrannoAddon.db.profile.darkness = value end,
            min = 0.1, max = 1, step = 0.1,
        },
        reload = {
            order = 4,
            type = "execute",
            name = "Reload UI",
            desc = "Reloads the UI",
            func = function() ReloadUI() end
        },
        hintOne = {
            order = 5,
            type = "description",
            name = "Hint: You need to reload the ui for the changes to take effect",
        },
        hintTwo = {
            order = 6,
            type = "description",
            name = "Hint: You can also use /granno to open the options menu",
        },
    }
}
GrannoAddon.defaults = {
    profile = {
        classBar = true,
        totemBar = true,
        darkness = 0.1,
    },
}
function GrannoAddon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("GrannoAddonDB", self.defaults, true)
    AC:RegisterOptionsTable("GrannoAddon_Options", self.options)
    self.optionsFrame = ACD:AddToBlizOptions("GrannoAddon_Options", "GrannoAddon")

    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    AC:RegisterOptionsTable("GrannoAddon_Profiles", profiles)
    ACD:AddToBlizOptions("GrannoAddon_Profiles", "Profiles", "GrannoAddon")


    self:RegisterChatCommand("granno", "SlashCommand")

    GrannoAddon:loadConfig()
end

function GrannoAddon:loadConfig()
    if GrannoAddon.db.profile.totemBar then
        TotemFrame:Hide()
        TotemFrame:HookScript("OnShow", function(self) self:Hide() end)
    end
    if self.db.profile.classBar then
        local _, Class = UnitClass("player")

        -- ROGUE
        if Class == "ROGUE" then
            ComboPointPlayerFrame:Hide()
            ComboPointPlayerFrame:HookScript("OnShow", function(self) self:Hide() end)
        end
        -- DRUID
        if Class == "DRUID" then
            ComboPointDruidPlayerFrame:Hide()
            ComboPointDruidPlayerFrame:HookScript("OnShow", function(self) self:Hide() end)
        end
        -- PALADIN
        if Class == "EVOKER" then
            EssencePlayerFrame:Hide()
            EssencePlayerFrame:HookScript("OnShow", function(self) self:Hide() end)
        end
        if Class == "PALADIN" then
            PaladinPowerBarFrame:Hide()
            PaladinPowerBarFrame:HookScript("OnShow", function(self) self:Hide() end)
        end

        -- WARLOCK
        if Class == "WARLOCK" then
            WarlockPowerFrame:Hide()
            WarlockPowerFrame:HookScript("OnShow", function(self) self:Hide() end)
        end

        -- DEATH KNIGHT
        if Class == "DEATHKNIGHT" then
            RuneFrame:Hide()
            RuneFrame:HookScript("OnShow", function(self) self:Hide() end)
        end

        -- MAGE
        if Class == "MAGE" then
            MageArcaneChargesFrame:Hide()
            MageArcaneChargesFrame:HookScript("OnShow", function(self) self:Hide() end)
        end

        -- PRIEST
        if Class == "PRIEST" then
            PriestBarFrame:Hide()
            PriestBarFrame:HookScript("OnShow", function(self) self:Hide() end)
        end

        -- MONK
        if Class == "MONK" then
            MonkHarmonyBarFrame:Hide()
            MonkHarmonyBarFrame:HookScript("OnShow", function(self) self:Hide() end)
        end

    end

    -- StanceBar
    for w = 1, 10 do
        _G["StanceButton" .. w .. "NormalTexture"]:SetVertexColor(GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness)

    end

    -- PET BAR
    for h = 1, 10 do
        _G["PetActionButton" .. h .. "NormalTexture"]:SetVertexColor(GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness)
    end

    -- FRAMES


    -- Target
    TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    TargetFrame.TargetFrameContainer.FrameTexture:SetDesaturated(true)
    TargetFrameToT.FrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    TargetFrameToT.FrameTexture:SetDesaturated(true)


    -- Focus
    FocusFrame.TargetFrameContainer.FrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    FocusFrame.TargetFrameContainer.FrameTexture:SetDesaturated(true)
    FocusFrameToT.FrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    FocusFrameToT.FrameTexture:SetDesaturated(true)

    -- Player
    PlayerFrame.PlayerFrameContainer.FrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    PlayerFrame.PlayerFrameContainer.FrameTexture:SetDesaturated(true)

    -- Pet
    PetFrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    PetFrameTexture:SetDesaturated(true)

    -- Minimap
    MinimapCompassTexture:SetVertexColor(GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    MinimapCompassTexture:SetDesaturated(true)

    -- Experience and Reputation Bar
    StatusTrackingBarManager.TopBarFrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)
    StatusTrackingBarManager.BottomBarFrameTexture:SetVertexColor(GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness,
        GrannoAddon.db.profile.darkness)


    -- Bar Art
    MainMenuBar.EndCaps.RightEndCap:SetDesaturated(true)
    MainMenuBar.EndCaps.LeftEndCap:SetDesaturated(true)
    for i, j in pairs({
        MainMenuBar.EndCaps.LeftEndCap,
        MainMenuBar.BorderArt,
        MainMenuBar.EndCaps.RightEndCap,
        ActionButton1.RightDivider,
        ActionButton2.RightDivider,
        ActionButton3.RightDivider,
        ActionButton4.RightDivider,
        ActionButton5.RightDivider,
        ActionButton6.RightDivider,
        ActionButton7.RightDivider,
        ActionButton8.RightDivider,
        ActionButton9.RightDivider,
        ActionButton10.RightDivider,
        ActionButton11.RightDivider,
    }) do
        j:SetVertexColor(GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness)
    end


    -- Quick Join Toast Button
    QuickJoinToastButton:Hide()

    -- Action Bars
    for i = 1, 12 do
        _G["ActionButton" .. i .. "NormalTexture"]:SetVertexColor(GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness,
            GrannoAddon.db.profile.darkness)
        _G["MultiBarBottomRightButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
        _G["MultiBarBottomLeftButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
        _G["MultiBarLeftButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
        _G["MultiBarRightButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
        _G["MultiBar5Button" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
        _G["MultiBar6Button" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
        _G["MultiBar7Button" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness, GrannoAddon.db.profile.darkness)
    end
end

function GrannoAddon:SlashCommand()
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end
