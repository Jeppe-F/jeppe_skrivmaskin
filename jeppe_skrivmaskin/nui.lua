local display = false

RegisterCommand("skrivmaskin", function(source)
    SetDisplay(not display)
end)

RegisterNUICallback("main", function(data)
    TriggerEvent("pNotify:SendNotification",{text = data.text, type = "normal", timeout = 5000, layout = "bottomcenter"})
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    TriggerEvent("pNotify:SendNotification",{text = "Du skrev ej in något värde", type = "warning", timeout = 5000, layout = "bottomcenter"})
    SetDisplay(false)
end)

RegisterNUICallback("exit", function(data) 
    TriggerEvent("pNotify:SendNotification",{text = "Du gick ur skrivmaskinen", type = "normal", timeout = 5000, layout = "bottomcenter"})
    SetDisplay(false)
end)

Citizen.CreateThread(function()
    local waitTime = 0
    while true do
        Citizen.Wait(waitTime)

        if isVisible == true then
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 18, true) -- Enter
            DisableControlAction(0, 322, true) -- ESC
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
            waitTime = 0
        else
            waitTime = 50
        end
    end
end)


function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type="ui",
        status = bool,
    })
end
