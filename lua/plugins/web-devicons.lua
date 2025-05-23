
local imageFolder = {
	icon = "󰉏",
	color = "#8bc34a",
	name = "image"
}

local distFolder = {
	icon = "󱃬",
	color = "#607d8b",
	name = "dist"
}

local testFolder = {
	icon = "",
	color = "#f443ee",
	name = "test"
}

local overrideType = {
	tsx = {
		icon = "󰜈",
		color = "#f44336",
		name = "Tsx"
	},
	vue = {
		icon = "󰹭",
		color = "#7bd88f",
		name = "Vue"
	},
	ts = {
		icon = "",
		color = "#00bcd4",
		name = "Ts"
	},
	js = {
		icon = "",
		color = "#f0d809",
		name = "Js"
	},
	json = {
		icon = "󰘦",
		color = "#f0d809",
		name = "Json"
	}
}

local overrideMap = {
	[".vscode"] = {
		icon = "󰨞",
		color_icons = "#795548",
		name = "VsCode"
	},
	[".git"] = {
		icon = "",
		color = "#ff5722",
		name = ".git"
	},
	[".github"] = {
		icon = "",
		color = "#ef3b78",
		name = ".github"
	},

	["build"] = {
		icon = "",
		color = "#795548",
		name = "build"
	},

	["src"] = {
		icon = "",
		color = "#f44336",
		name = "src"
	},
	["android"] = {
		icon = "",
		color = "#ffd200",
		name = "android"
	},
	["ios"] = {
		icon = "",
		color = "#fa5f94",
		name = "ios"
	},
	["macos"] = {
		icon = "",
		color = "#3bf7d1",
		name = "ios"
	},
	["windows"] = {
		icon = "󰨡",
		color = "#3bf7d1",
		name = "windows"
	},
	["linux"] = {
		icon = "󰌽",
		color = "#3bf7d1",
		name = "linux"
	},
	["web"] = {
		icon = "󰾔",
		color = "#01e8fe",
		name = "web"
	},
	["electron"] = {
		icon = "󱀤",
		color = "#01e8fe",
		name = "electron"
	},

	["test"] = testFolder,
	["__tests__"] = testFolder,

	["image"] = imageFolder,
	["images"] = imageFolder,
	["img"] = imageFolder,
	["imgs"] = imageFolder,
	["icon"] = imageFolder,
	["icons"] = imageFolder,

	["dist"] = distFolder,
	["dist-electron"] = distFolder,

	["node_modules"] = {
		icon = "󰎙",
		color = "#25dea7",
		name = "node_modules"
	}
}

local config = {
	default = false,
	color_icons = true,
	strict = true,
	override = overrideType,
	override_by_filename = overrideMap,
	-- override_by_extension = overrideMap
}

local M = {
	'nvim-tree/nvim-web-devicons',
	event = 'VimEnter',
    priority = 100000,
	config = function ()
		require('nvim-web-devicons').setup(config)
	end,
}

return M
