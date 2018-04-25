local config = require "configuration"

local craftingCombinator = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])
craftingCombinator.name = config.CRAFTINGCOMBINATOR_NAME
craftingCombinator.minable.result = config.CRAFTINGCOMBINATOR_NAME

local craftingCombinatorRecipe = table.deepcopy(data.raw.recipe["arithmetic-combinator"])
craftingCombinatorRecipe.name = config.CRAFTINGCOMBINATOR_NAME
craftingCombinatorRecipe.result = config.CRAFTINGCOMBINATOR_NAME
table.insert(data.raw["technology"]["circuit-network"].effects, {type = "unlock-recipe", recipe = config.CRAFTINGCOMBINATOR_NAME})

data:extend{craftingCombinator, craftingCombinatorRecipe}

data:extend(
    {
        {
            type = "item",
            name = config.CRAFTINGCOMBINATOR_NAME,
            icon = "__base__/graphics/icons/arithmetic-combinator.png",
            icon_size = 32,
            flags = {"goes-to-quickbar"},
            subgroup = "circuit-network",
            order = "e[crafting-combinator]",
            place_result = config.CRAFTINGCOMBINATOR_NAME,
            stack_size = 50
        }
    }
)