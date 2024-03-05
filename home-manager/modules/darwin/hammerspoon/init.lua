-- luacheck: globals hs, ignore 122
package.path = package.path .. ";@fennelLib@"

local fennel = require("fennel")

debug.traceback = fennel.traceback

fennel.install()

require("fnl.init")({
	hs = hs,
	paths = { yabai = "@yabaiPath@" },
})
