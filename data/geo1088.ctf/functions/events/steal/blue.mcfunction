# Steal Blue - When the blue flag is stolen.

# Scoreboard handling
scoreboard players set @e[team=BlueData] FlagPresent 0
scoreboard players set @p[scores={StealsFlag=1},team=!Blue] CarryingBlueFlag 1

# Physical replacements/effects
execute at @e[team=BlueData] run setblock ~ ~-1 ~ air replace
execute at @e[team=BlueData] run particle minecraft:smoke ~ ~-1 ~ 0.5 1 0.5 0.15 200
replaceitem entity @p[scores={StealsFlag=1},team=!Blue] armor.head blue_banner{BlockEntityTag:{Patterns:[{Pattern:rd,Color:3},{Pattern:sc,Color:0}]}}
data merge entity @e[team=BlueData,limit=1] {CustomName:"\"Flag stolen!\"",CustomNameVisible:1b}

# Text
tellraw @a[team=Blue] [{"selector": "@p[scores={StealsFlag=1}]", "color": "yellow"}, " has ", {"text": "stolen your flag!", "color": "gold"}]
tellraw @a[team=!Blue,scores={StealsFlag=1}] [{"text": "You've stolen the enemy flag!", "color": "green"}]
tellraw @a[team=!Blue,scores={StealsFlag=0}] [{"selector": "@p[scores={StealsFlag=1}]", "color": "yellow"}, " has ", {"text": "stolen the enemy flag!", "color": "green"}]

# Sound
# TODO: is there an easier way to do sound than this execute thing?
execute as @a[team=!Blue,scores={StealsFlag=1}] at @s run playsound minecraft:entity.experience_orb.pickup master @s
execute as @a[team=Blue] at @s run playsound minecraft:entity.generic.explode master @s

# Done!
scoreboard players set @p[scores={StealsFlag=1},team=!Blue] StealsFlag 0