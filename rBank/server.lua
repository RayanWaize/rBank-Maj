ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("gBank:deposer")
AddEventHandler("gBank:deposer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque', "Vous avez deposé ~g~"..total.."$~s~ à la banque !", 'CHAR_BANK', 10)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end) 

RegisterServerEvent("gBank:retirer")
AddEventHandler("gBank:retirer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getAccount('bank').money
    
    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque', "Vous avez retiré ~g~"..total.."$~s~ de la banque !", 'CHAR_BANK', 10)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end)


RegisterServerEvent("bank:solde") 
AddEventHandler("bank:solde", function(action, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getAccount('bank').money
    TriggerClientEvent("solde:argent", source, playerMoney)
end)


RegisterServerEvent('gBank:transfer')
AddEventHandler('gBank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent('esx:showAdvancedNotification', _source, "Problème", 'Banque', "Ce destinataire n'existe pas.", 'CHAR_BANK', 10)
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = zPlayer.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('esx:showAdvancedNotification', _source, "Problème", 'Banque', "Vous ne pouvez pas transférer d'argent à vous-même.", 'CHAR_BANK', 10)
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('esx:showAdvancedNotification', _source, 'Banque', "Problème", "Vous n'avez pas assez d'argent en banque.", 'CHAR_BANK', 10)
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
                    TriggerClientEvent('esx:showAdvancedNotification', _source, "Succès", 'Banque', "Transfert réussi vous avez envoyé "..tonumber(amountt).." $ à "..zPlayer.getName(), 'CHAR_BANK', 10)
                    TriggerClientEvent('esx:showAdvancedNotification', to, "Banque", 'Banque', "Vous avez recu "..tonumber(amountt).." $ de la part de "..xPlayer.getName(), 'CHAR_BANK', 10)
			end
		end
	end
end)
