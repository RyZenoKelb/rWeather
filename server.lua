RegisterNetEvent("changerMeteo")
AddEventHandler("changerMeteo", function(codeMeteo)
    SetWeatherTypeNowPersist(codeMeteo)
end)
