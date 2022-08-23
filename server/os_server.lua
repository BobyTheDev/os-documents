local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent(Config.OSCoreName ..':GetObject', function(obj) QB = obj end)

QBCore.Functions.CreateCallback('os_documents:submitDocument', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    local db_form = nil;
    local _data = data;
    exports['ghmattimysql']:execute("INSERT INTO player_documents (owner, data) VALUES (@owner, @data)", {['@owner'] = Player.PlayerData.citizenid, ['@data'] = json.encode(data)}, function(id)
        if id ~= nil then
             exports['ghmattimysql']:execute('SELECT * FROM player_documents WHERE id = @id', {['@id']=id.insertId}, function (result)
                if(result[1] ~= nil) then
                    db_form = result[1]
                    db_form.data = json.decode(result[1].data)
                    cb(db_form)
                end
            end)
        else
            cb(db_form)
        end
    end)
end)

QBCore.Functions.CreateCallback('os_documents:deleteDocument', function(source, cb, id)
    local db_document = nil;
    local Player = QBCore.Functions.GetPlayer(source)
    exports['ghmattimysql']:execute('DELETE FROM player_documents WHERE id = @id AND owner = @owner', {
        ['@id']  = id,
        ['@owner'] = Player.PlayerData.citizenid
    }, function(result)
        if result ~= nil then
            TriggerClientEvent(Config.OSCoreName.. ':Notify', source, 'Document deleted', 'inform')
            cb(true)
        else
            TriggerClientEvent(Config.OSCoreName.. ':Notify', source, 'Cound\'t delete documet', 'error')
            cb(false)
        end
    end)
end)

QBCore.Functions.CreateCallback('os_documents:getPlayerDocuments', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local forms = {}
    if Player ~= nil then
        exports['ghmattimysql']:execute("SELECT * FROM player_documents WHERE owner = @owner", {
            ['@owner'] = Player.PlayerData.citizenid
        }, function(result)
        if #result > 0 then
            for i=1, #result, 1 do
                local tmp_result = result[i]
                tmp_result.data = json.decode(result[i].data)
                table.insert(forms, tmp_result)
            end
                cb(forms)
            end
        end)
    end
end)

QBCore.Functions.CreateCallback('os_documents:getPlayerDetails', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local cb_data = nil
    exports['ghmattimysql']:execute("SELECT charinfo FROM players WHERE citizenid = @owner", {
        ['@owner'] = Player.PlayerData.citizenid
    }, function(result)
        if result[1] ~= nil then
            cb_data = result[1]
            cb(cb_data)
        else
            cb(cb_data)
        end

    end)

end)


RegisterServerEvent('os_documents:ShowToPlayer')
AddEventHandler('os_documents:ShowToPlayer', function(targetID, aForm)
    TriggerClientEvent('os_documents:viewDocument', targetID, aForm)
end)

RegisterServerEvent('os_documents:CopyToPlayer')
AddEventHandler('os_documents:CopyToPlayer', function(targetID, aForm)
    local _source   = source
    local _targetid = QBCore.Functions.GetPlayer(targetID)
    local _aForm    = aForm
    exports['ghmattimysql']:execute("INSERT INTO player_documents (owner, data) VALUES (@owner, @data)", {['@owner'] = _targetid.PlayerData.citizenid, ['@data'] = json.encode(aForm)}, function(id)
        if id ~= nil then
		    exports['ghmattimysql']:execute('SELECT * FROM player_documents WHERE id = @id', {['@id']=id.insertId}, function (result)
                if(result[1] ~= nil) then
                    db_form = result[1]
                    db_form.data = json.decode(result[1].data)
                    TriggerClientEvent('os_documents:copyForm', _targetid.PlayerData.source, db_form)
                    TriggerClientEvent(Config.OSCoreName ..':Notify', _targetid.PlayerData.source, 'You received a copy of a document from a player', 'inform')
                    TriggerClientEvent(Config.OSCoreName ..':Notify', _source, 'Form copied to a player', 'inform')
                else
                    TriggerClientEvent(Config.OSCoreName.. ':Notify', _source, 'Could not copy form to player', 'error')
                end
            end)
        else
            TriggerClientEvent(Config.OSCoreName.. ':Notify', _source, 'Could not copy form to player', 'error')
        end
    end)
end)
