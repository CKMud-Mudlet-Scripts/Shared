local Player = FRIED.Player

local function dam(stat1, stat2, supreme, boosted)
    local supreme_multi = supreme and 7500 or 5000
    local boost_multi = (boosted or supreme) and 750 or 500
    return
        math.floor(
            ((stat1 * 1.8) * supreme_multi) +
            ((stat2 / 5) * supreme_multi) +
            (Player.DAMROLL * boost_multi) +
            (Player.HITROLL * boost_multi) +
            (math.min((Player.MAXPL / 200), 2000000))
        )
end

function heal_factor()
    return Player.Stats.INT * 5000 + Player.Stats.WIS * 25000 + Player.MAXPL / 100
end

function ki_dam(supreme, boosted)
    return dam(Player.Stats.INT, Player.Stats.WIS, supreme, boosted)
end

function phy_dam(supreme, boosted)
    return dam(Player.Stats.STR, Player.Stats.SPD, supreme, boosted)
end
