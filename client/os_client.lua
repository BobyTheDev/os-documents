local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local UI_MOUSE_FOCUS = false
local USER_DOCUMENTS = {}
local fontId
local CURRENT_DOCUMENT = nil
local DOCUMENT_FORMS = nil

local MENU_OPTIONS = {
    x = 0.5,
    y = 0.0269,
    width = Config.OSWid,
    height = Config.OShei,
    scale = Config.OSscale,
    font = fontId,
    menu_title = Config.OSCommunityActionText,
    menu_subtitle = ('document options'),
    color_r = Config.OSr,
    color_g = Config.OSg,
    color_b = Config.OSb,
}


Citizen.CreateThread(function()
	while QB == nil do
		TriggerEvent(Config.OSCoreName.. ':GetObject', function(obj) QB = obj end)
		Citizen.Wait(69)
	end

    PlayerData = QBCore.Functions.GetPlayerData()

    DOCUMENT_FORMS = Config.OSCommunity

    if Config.UseOSCustomFonts == true then
        RegisterFontFile(Config.CustomOSFontFile)
        fontId = RegisterFontId(Config.CustomOSFontId)
        MENU_OPTIONS.font = fontId
    else
        MENU_OPTIONS.font = Config.OSCommunityFont
    end


    GetAllUserForms()
    SetNuiFocus(false, false)

end)

RegisterNetEvent(Config.OSCoreName.. ':Client:OnPlayerLoaded')
AddEventHandler(Config.OSCoreName.. ':Client:OnPlayerLoaded', function()
    GetAllUserForms()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if IsControlJustReleased(0, Config.OSCommunityMenuKey) and GetLastInputMethod(2) then
            Menu.hidden = false
            OpenMainMenu()
    	end
        Menu.renderGUI(MENU_OPTIONS)
    end
 end)

function OpenMainMenu()
    ClearMenu()
    Menu.addButton("Public Documents", "OpenNewPublicFormMenu", nil)
    Menu.addButton("Job Documents", "OpenNewJobFormMenu", nil)	
    Menu.addButton("Saved Documents", "OpenMyDocumentsMenu", nil)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function CopyFormToPlayer(aPlayer)
    TriggerServerEvent('os_documents:CopyToPlayer', aPlayer, CURRENT_DOCUMENT)
    CURRENT_DOCUMENT = nil;
    CloseMenu()
end

function ShowToNearestPlayers(aDocument)
    ClearMenu()
    local players_clean = GetNeareastPlayers()
    CURRENT_DOCUMENT = aDocument
    if #players_clean > 0 then
        for i=1, #players_clean, 1 do
            Menu.addButton(players_clean[i].playerName .. "[" .. tostring(players_clean[i].playerId) .. "]", "ShowDocument", players_clean[i].playerId)
        end
    else
        Menu.addButton("No players found", "CloseMenu", nil)
    end
    Menu.addButton("Close", "CloseMenu", nil)
end

function CopyToNearestPlayers(aDocument)
    ClearMenu()
    local players_clean = GetNeareastPlayers()
    CURRENT_DOCUMENT = aDocument
    if #players_clean > 0 then
        for i=1, #players_clean, 1 do
            Menu.addButton(players_clean[i].playerName .. "[" .. tostring(players_clean[i].playerId) .. "]", "CopyFormToPlayer", players_clean[i].playerId)
        end
    else
        Menu.addButton("No players found", "CloseMenu", nil)
    end
    Menu.addButton("Close", "CloseMenu", nil)
end

function OpenNewPublicFormMenu()
    ClearMenu()
    for i=1, #Config.OSCommunity["public"], 1 do
        Menu.addButton(Config.OSCommunity["public"][i].headerTitle, "CreateNewForm", Config.OSCommunity["public"][i])
    end
    Menu.addButton("Close","CloseMenu",nil)
    Menu.hidden = false
end

function OpenNewJobFormMenu()
    ClearMenu()
    PlayerData = QBCore.Functions.GetPlayerData()
        for i=1, #Config.OSCommunity[PlayerData.job.name], 1 do
            Menu.addButton(Config.OSCommunity[PlayerData.job.name][i].headerTitle, "CreateNewForm", Config.OSCommunity[PlayerData.job.name][i])
    end
    Menu.addButton("Close","CloseMenu",nil)
    Menu.hidden = false
end

function OpenMyDocumentsMenu()
    ClearMenu()
    for i=#USER_DOCUMENTS, 1, -1 do
        local date_created = ""
        if USER_DOCUMENTS[i].data.headerDateCreated ~= nil then
            date_created = USER_DOCUMENTS[i].data.headerDateCreated .. " - "
        end
        Menu.addButton(date_created .. USER_DOCUMENTS[i].data.headerTitle, "OpenFormPropertiesMenu", USER_DOCUMENTS[i])
    end
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function OpenFormPropertiesMenu(aDocument)
    ClearMenu()
    Menu.addButton("View", "ViewDocument", aDocument.data)
    Menu.addButton("Show", "ShowToNearestPlayers", aDocument.data)
    Menu.addButton("Give Copy", "CopyToNearestPlayers", aDocument.data)
    Menu.addButton("Delete", "OpenDeleteFormMenu", aDocument)
    Menu.addButton("Go Back", "OpenMyDocumentsMenu", nil)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function OpenDeleteFormMenu(aDocument)
    ClearMenu()
    Menu.addButton("Yes Delete", "DeleteDocument", aDocument)
    Menu.addButton("Go Back", "OpenFormPropertiesMenu", aDocument)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function CloseMenu()
    ClearMenu()
    Menu.hidden = true
end

function DeleteDocument(aDocument)
    QBCore.Functions.TriggerCallback('os_documents:deleteDocument', function (cb)
        if cb == true then
            for i=1, #USER_DOCUMENTS, 1 do
                if USER_DOCUMENTS[i].id == aDocument.id then
                    key_to_remove = i
                end
            end
            if key_to_remove ~= nil then
                table.remove(USER_DOCUMENTS, key_to_remove)
            end
            OpenMyDocumentsMenu()
        end
    end, aDocument.id)
end

function CreateNewForm(aDocument)
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('os_documents:getPlayerDetails', function (cb_player_details)
        if cb_player_details ~= nil then
            SetNuiFocus(true, true)
            aDocument.headerFirstName = PlayerData.charinfo.firstname
            aDocument.headerLastName = PlayerData.charinfo.lastname
            aDocument.headerDateOfBirth = PlayerData.charinfo.birthdate
            aDocument.headerJobLabel = PlayerData.job.name
            aDocument.headerJobGrade = PlayerData.charinfo.nationality
            aDocument.locale = Config.OSCommunityLocale
            SendNUIMessage({
                type = "createNewForm",
                data = aDocument
            })
        else
        end
    end, data)
end

function ShowDocument(aPlayer)
        TriggerServerEvent('os_documents:ShowToPlayer', aPlayer, CURRENT_DOCUMENT)
        CURRENT_DOCUMENT = nil
        CloseMenu()
end

RegisterNetEvent('os_documents:viewDocument')
AddEventHandler('os_documents:viewDocument', function( data )
    ViewDocument(data)
end)

function ViewDocument(aDocument)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "ShowDocument",
        data = aDocument
    })
end

RegisterNetEvent('os_documents:copyForm')
AddEventHandler('os_documents:copyForm', function(db_form)
    table.insert(USER_DOCUMENTS, db_form)
    OpenFormPropertiesMenu(db_form)
end)

function GetAllUserForms()
    QBCore.Functions.TriggerCallback('os_documents:getPlayerDocuments', function (cb_forms)
        if cb_forms ~= nil then
            USER_DOCUMENTS = cb_forms
        else
        end
    end, data)

end

RegisterNUICallback('form_close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('form_submit', function(data, cb)
    CloseMenu()
    QBCore.Functions.TriggerCallback('os_documents:submitDocument', function (cb_form)
        if cb_form ~= nil then
            table.insert(USER_DOCUMENTS, cb_form)
            OpenFormPropertiesMenu(cb_form)
        else
        end
    end, data)
    SetNuiFocus(false, false)
end)

function GetNeareastPlayers()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    local players_clean = {}
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)
            if closestDistance == -1 or closestDistance > distance then
                for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            found_players = true
            table.insert(players_clean, {playerName = GetPlayerName(closestPlayers[i]), playerId = GetPlayerServerId(closestPlayers[i])} )
        end
    end
            end
        end
    end
    return players_clean
end
