GrannoAddon = LibStub("AceAddon-3.0"):NewAddon("GrannoAddon", "AceConsole-3.0", "AceTimer-3.0", "AceEvent-3.0",
    "AceHook-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")



GrannoAddon.options = {
    name = "Granno Addon",
    handler = GrannoAddon,
    type = "group",
    childGroups = "tab",
    args = {
        Reload = {
            order = 1,
            type = "execute",
            name = "Reload UI",
            desc = "Reloads the UI",
            func = function() ReloadUI() end
        },
        HintOne = {
            order = 2,
            type = "description",
            name = "Hint: You need to reload the ui for the changes to take effect",
        },
        HintTwo = {
            order = 3,
            type = "description",
            name = "Hint: You can also use /granno to open the options menu",
        },
        General = {
            order = 1,
            type = "group",
            name = "General",
            args = {
                ClassBar = {
                    order = 1,
                    type = "toggle",
                    name = "Hide ClassBar",
                    desc = "Hides ClassBar like Holy Power, Combo Points, etc.",
                    get = function(info) return GrannoAddon.db.profile.ClassBar end,
                    set = function(info, value) GrannoAddon.db.profile.ClassBar = value end,
                },
                TotemBar = {
                    order = 2,
                    type = "toggle",
                    name = "Hide TotemBar",
                    desc = "Hides TotemBar",
                    get = function(info) return GrannoAddon.db.profile.TotemBar end,
                    set = function(info, value) GrannoAddon.db.profile.TotemBar = value end,
                },
                PlayerCastBarToggle = {
                    order = 3,
                    type = "toggle",
                    name = "Hide Player CastBar",
                    desc = "Hides Player CastBar",
                    get = function(info) return GrannoAddon.db.profile.PlayerCastBarToggle end,
                    set = function(info, value) GrannoAddon.db.profile.PlayerCastBarToggle = value end,
                },
                MicroButtonBar = {
                    order = 4,
                    type = "toggle",
                    name = "Hide Micro ButtonBar",
                    desc = "Hides Micro ButtonBar",
                    get = function(info) return GrannoAddon.db.profile.MicroButtonBar end,
                    set = function(info, value) GrannoAddon.db.profile.MicroButtonBar = value end,
                },
                BagBar = {
                    order = 5,
                    type = "toggle",
                    name = "Hide BagBar",
                    desc = "Hides BagBar",
                    get = function(info) return GrannoAddon.db.profile.BagBar end,
                    set = function(info, value) GrannoAddon.db.profile.BagBar = value end,
                },

                StanceBar = {
                    order = 6,
                    type = "toggle",
                    name = "Hide StanceBar",
                    desc = "Hides StanceBar",
                    get = function(info) return GrannoAddon.db.profile.StanceBar end,
                    set = function(info, value) GrannoAddon.db.profile.StanceBar = value end,
                },
                PetBar = {
                    order = 7,
                    type = "toggle",
                    name = "Hide PetBar",
                    desc = "Hides PetBar",
                    get = function(info) return GrannoAddon.db.profile.PetBar end,
                    set = function(info, value) GrannoAddon.db.profile.PetBar = value end,
                },
            },

        },

        Darkening = {
            order = 2,
            type = "group",
            name = "Darkening",
            args = {
                Darkness = {
                    order = 1,
                    type = "range",
                    name = "Darkness",
                    desc = "Determines how dark the ui is, 0.1 is the darkest, 1 is the lightest",
                    get = function(info) return GrannoAddon.db.profile.Darkness end,
                    set = function(info, value) GrannoAddon.db.profile.Darkness = value end,
                    min = 0.1, max = 1, step = 0.1,
                },
                DarkActionBars = {
                    order = 2,
                    type = "toggle",
                    name = "Darken Action Bars",
                    desc = "Determines if the action bars are darkened",
                    get = function(info) return GrannoAddon.db.profile.DarkActionBars end,
                    set = function(info, value) GrannoAddon.db.profile.DarkActionBars = value end,
                },
                DarkMinimap = {
                    order = 3,
                    type = "toggle",
                    name = "Darken Minimap",
                    desc = "Determines if the minimap is darkened",
                    get = function(info) return GrannoAddon.db.profile.DarkMinimap end,
                    set = function(info, value) GrannoAddon.db.profile.DarkMinimap = value end,
                },
                DarkFrames = {
                    order = 4,
                    type = "toggle",
                    name = "Darken Frames",
                    desc = "Determines if the frames are darkened",
                    get = function(info) return GrannoAddon.db.profile.DarkFrames end,
                    set = function(info, value) GrannoAddon.db.profile.DarkFrames = value end,
                },
                DarkRepAndExp = {
                    order = 5,
                    type = "toggle",
                    name = "Darken Reputation and Experience",
                    desc = "Determines if the reputation and experience bars are darkened",
                    get = function(info) return GrannoAddon.db.profile.DarkRepAndExp end,
                    set = function(info, value) GrannoAddon.db.profile.DarkRepAndExp = value end,

                },
            },
        },

    },
}

GrannoAddon.defaults = {
    profile = {
        ClassBar = true,
        TotemBar = true,
        Darkness = 0.1,
        MicroButtonBar = false,
        BagBar = false,
        StanceBar = false,
        PetBar = false,
        DarkActionBars = true,
        DarkMinimap = true,
        DarkFrames = true,
        DarkRepAndExp = true,
        PlayerCastBarToggle = false,
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

    GrannoAddon:HideMicroBar()
    GrannoAddon:HideBagBar()
    GrannoAddon:HideStanceBar()
    GrannoAddon:HideClassBar()
    GrannoAddon:HidePetBar()
    GrannoAddon:SetCastBar()


    if GrannoAddon.db.profile.DarkActionBars then
        GrannoAddon:DarkenActionBars()
    end
    if GrannoAddon.db.profile.DarkMinimap then
        GrannoAddon:DarkenMinimap()
    end
    if GrannoAddon.db.profile.DarkFrames then
        GrannoAddon:DarkenFrames()
    end
    if GrannoAddon.db.profile.DarkRepAndExp then
        GrannoAddon:DarkenRepAndExp()
    end

    -- Quick Join Toast Button
    QuickJoinToastButton:Hide()

end

function GrannoAddon:HideBagBar()

    -- Add hook script
    if GrannoAddon.db.profile.BagBar then
        MainMenuBarBackpackButton:Hide()
        MainMenuBarBackpackButton:HookScript("OnShow", function(self) self:Hide() end)
        CharacterBag0Slot:Hide()
        CharacterBag0Slot:HookScript("OnShow", function(self) self:Hide() end)
        CharacterBag1Slot:Hide()
        CharacterBag1Slot:HookScript("OnShow", function(self) self:Hide() end)
        CharacterBag2Slot:Hide()
        CharacterBag2Slot:HookScript("OnShow", function(self) self:Hide() end)
        CharacterBag3Slot:Hide()
        CharacterBag3Slot:HookScript("OnShow", function(self) self:Hide() end)
        CharacterReagentBag0Slot:Hide()
        CharacterReagentBag0Slot:HookScript("OnShow", function(self) self:Hide() end)
        BagBarExpandToggle:Hide()
        BagBarExpandToggle:HookScript("OnShow", function(self) self:Hide() end)
    else
        MainMenuBarBackpackButton:Show()
        CharacterBag0Slot:Show()
        CharacterBag1Slot:Show()
        CharacterBag2Slot:Show()
        CharacterBag3Slot:Show()
        CharacterReagentBag0Slot:Show()
        BagBarExpandToggle:Show()
    end
end

function GrannoAddon:HideMicroBar()
    if GrannoAddon.db.profile.MicroButtonBar then
        MainMenuMicroButton:Hide()
        MainMenuMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        CharacterMicroButton:Hide()
        CharacterMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        SpellbookMicroButton:Hide()
        SpellbookMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        TalentMicroButton:Hide()
        TalentMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        AchievementMicroButton:Hide()
        AchievementMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        QuestLogMicroButton:Hide()
        QuestLogMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        GuildMicroButton:Hide()
        GuildMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        LFDMicroButton:Hide()
        LFDMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        CollectionsMicroButton:Hide()
        CollectionsMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        EJMicroButton:Hide()
        EJMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        StoreMicroButton:Hide()
        StoreMicroButton:HookScript("OnShow", function(self) self:Hide() end)
        CollectionsMicroButton:Hide()
        CollectionsMicroButton:HookScript("OnShow", function(self) self:Hide() end)
    else
        MainMenuMicroButton:Show()
        CharacterMicroButton:Show()

        SpellbookMicroButton:Show()

        TalentMicroButton:Show()

        AchievementMicroButton:Show()

        QuestLogMicroButton:Show()

        GuildMicroButton:Show()

        LFDMicroButton:Show()

        CollectionsMicroButton:Show()

        EJMicroButton:Show()

        StoreMicroButton:Show()

        CollectionsMicroButton:Show()

    end
end

function GrannoAddon:HideStanceBar()
    if GrannoAddon.db.profile.StanceBar then
        StanceBar:Hide()
        StanceBar:HookScript("OnShow", function(self) self:Hide() end)
    else
        StanceBar:Show()
    end
end

function GrannoAddon:HideTotemBar()
    if GrannoAddon.db.profile.TotemBar then
        TotemFrame:Hide()
        TotemFrame:HookScript("OnShow", function(self) self:Hide() end)
    else
        TotemFrame:Show()
    end

end

function GrannoAddon:HidePetBar()
    if GrannoAddon.db.profile.PetBar then
        PetActionBar:Hide()
        PetActionBar:HookScript("OnShow", function(self) self:Hide() end)
    else
        PetActionBar:Show()
    end
end

function GrannoAddon:HideClassBar()



    if GrannoAddon.db.profile.ClassBar then
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
end

function GrannoAddon:SetCastBar()
    if GrannoAddon.db.profile.PlayerCastBarToggle then
        PlayerCastingBarFrame:Hide()
        PlayerCastingBarFrame:UnregisterAllEvents()
    else
        PlayerCastingBarFrame:Show()
        PlayerCastingBarFrame:RegisterAllEvents()
    end
end

function GrannoAddon:DarkenActionBars()
    if not GrannoAddon.db.profile.StanceBar then
        -- StanceBar
        for w = 1, 10 do
            _G["StanceButton" .. w .. "NormalTexture"]:SetVertexColor(GrannoAddon.db.profile.Darkness,
                GrannoAddon.db.profile.Darkness,
                GrannoAddon.db.profile.Darkness)

        end
    end
    if not GrannoAddon.db.profile.PetBar then
        -- PET BAR
        for h = 1, 10 do
            _G["PetActionButton" .. h .. "NormalTexture"]:SetVertexColor(GrannoAddon.db.profile.Darkness,
                GrannoAddon.db.profile.Darkness,
                GrannoAddon.db.profile.Darkness)
        end
    end

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
        j:SetVertexColor(GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness,
            GrannoAddon.db.profile.Darkness)
    end


    -- Action Bars
    for i = 1, 12 do
        _G["ActionButton" .. i .. "NormalTexture"]:SetVertexColor(GrannoAddon.db.profile.Darkness,
            GrannoAddon.db.profile.Darkness,
            GrannoAddon.db.profile.Darkness)
        _G["MultiBarBottomRightButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
        _G["MultiBarBottomLeftButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
        _G["MultiBarLeftButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
        _G["MultiBarRightButton" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
        _G["MultiBar5Button" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
        _G["MultiBar6Button" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
        _G["MultiBar7Button" .. i .. "NormalTexture"]:SetVertexColor(
            GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness)
    end
end

function GrannoAddon:DarkenMinimap()
    -- Minimap
    MinimapCompassTexture:SetVertexColor(GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    MinimapCompassTexture:SetDesaturated(true)
end

function GrannoAddon:DarkenRepAndExp()
    -- Experience and Reputation Bar
    StatusTrackingBarManager.TopBarFrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    StatusTrackingBarManager.BottomBarFrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
end

function GrannoAddon:DarkenFrames()
    -- Target
    TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    TargetFrame.TargetFrameContainer.FrameTexture:SetDesaturated(true)
    TargetFrameToT.FrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    TargetFrameToT.FrameTexture:SetDesaturated(true)


    -- Focus
    FocusFrame.TargetFrameContainer.FrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    FocusFrame.TargetFrameContainer.FrameTexture:SetDesaturated(true)
    FocusFrameToT.FrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    FocusFrameToT.FrameTexture:SetDesaturated(true)

    -- Player
    PlayerFrame.PlayerFrameContainer.FrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    PlayerFrame.PlayerFrameContainer.FrameTexture:SetDesaturated(true)

    -- Pet
    PetFrameTexture:SetVertexColor(GrannoAddon.db.profile.Darkness, GrannoAddon.db.profile.Darkness,
        GrannoAddon.db.profile.Darkness)
    PetFrameTexture:SetDesaturated(true)

end

function GrannoAddon:SlashCommand()
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end
