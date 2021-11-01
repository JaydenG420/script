local PetModule = require(game:GetService("ReplicatedStorage").Framework.Modules["1 | Directory"].Pets["Grab All Pets"])

local EmbedMessage = {
    ["username"] = "Pet Simulator X Pet Notifier";
    ["embeds"] = {
        {
            ["title"] = game.Players.LocalPlayer.Name.." hatched those pets: ";
            ["description"] = '';
        }
    }
}

game.Players.LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets.ChildAdded:Connect(function(Child)
    if Child.Name == 'Empty' then return end
    if not getgenv().PetNotifier then return end

    local PetID = nil
    local UID = Child.Name

    for i,v in next, workspace.__THINGS.__REMOTES["get stats"]:InvokeServer({})[1]['Pets'] do
        if v.uid == UID then
            PetID = v.id
        end
    end

    if table.find(WhitelistedPets, PetModule[tostring(PetID)].name) or table.find(WhitelistedRarities, PetModule[tostring(PetID)].rarity) then
        EmbedMessage.embeds.description = PetModule[tostring(PetID).name].. " ("..PetModule[tostring(PetID)].rarity..")"
        syn.request({Url = getgenv().Webhook ,Method = 'POST',Headers = {['Content-Type'] = 'application/json'},Body = game:GetService('HttpService'):JSONEncode(EmbedMessage)})
    end
end)