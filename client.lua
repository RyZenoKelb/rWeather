local typesMeteo = {
    {nom = "Ensoleillé", code = "EXTRASUNNY"},
    {nom = "Clair", code = "CLEAR"},
    {nom = "Nuageux", code = "CLOUDS"},
    {nom = "Brouillard", code = "FOGGY"},
    {nom = "Brumeux", code = "SMOG"},
    {nom = "Couvert", code = "OVERCAST"},
    {nom = "Pluie", code = "RAIN"},
    {nom = "Orage", code = "THUNDER"},
    {nom = "Éclaircies", code = "CLEARING"},
    {nom = "Neige", code = "SNOW"},
    {nom = "Blizzard", code = "BLIZZARD"},
    {nom = "Neige légère", code = "SNOWLIGHT"},
    {nom = "Noël", code = "XMAS"},
    {nom = "Halloween", code = "HALLOWEEN"},
}

local menuMeteo = RageUI.CreateMenu("Menu Météo", "Changer la météo")
local menuConfirmation = RageUI.CreateSubMenu(menuMeteo, "Confirmation", "Êtes-vous sûr de vouloir changer la météo ?")

menuMeteo.Closed = function()
    -- Actions à effectuer lorsque le menu est fermé
end

local function AfficherMenuConfirmation(nomMeteo, codeMeteo)
    RageUI.Visible(menuConfirmation, true)
    Citizen.CreateThread(function()
        while menuConfirmation ~= nil and menuConfirmation:IsVisible() do
            Citizen.Wait(0)
            RageUI.Text({message = "Changer la météo en " .. nomMeteo .. " ?", time_display = 1})
            if RageUI.Button("Oui", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent("changerMeteo", codeMeteo)
                menuConfirmation:Visible(false)
            end}) then
            elseif RageUI.Button("Non", nil, {RightLabel = "→"}, true, {onSelected = function()
                menuConfirmation:Visible(false)
            end}) then
            end
        end
    end)
end

local function OuvrirMenuMeteo()
    RageUI.Visible(menuMeteo, not menuMeteo:Visible())
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 289) then -- Touche F11
            OuvrirMenuMeteo()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if RageUI.Visible(menuMeteo) then
            RageUI.Draw2D()
            for _, v in ipairs(typesMeteo) do
                if RageUI.Button(v.nom, nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        AfficherMenuConfirmation(v.nom, v.code)
                    end
                }) then
                end
            end
        elseif RageUI.Visible(menuConfirmation) then
            RageUI.Draw2D()
        end
    end
end)
