-- Load fennel
package.loaded.fennel = dofile("fennel.lua")
table.insert(package.loaders or package.searchers, package.loaded.fennel.searcher)

-- Load luaunit test runner
local runner = require("test.luaunit").LuaUnit:new()
runner:setOutputType("tap")

local fennel = dofile("fennel.lua")

local function testAll(suites)
    local instances = {}

    for _, test in ipairs(suites) do
        local suite = fennel.dofile("test/" .. test .. ".fnl")

        for name, testfn in pairs(suite) do
            table.insert(instances, {name, testfn})
        end
    end

    return runner:runSuiteByInstances(instances)
end

if #arg == 0 then
    testAll({"core"})
else
    testAll(arg)
end

os.exit(runner.result.notSuccessCount == 0 and 0 or 1)
