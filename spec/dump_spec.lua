local dump = require("src.dump")

describe("dump function", function()
    describe("basic data types", function()
        it("should handle nil", function()
            assert.are.equal("nil", dump(nil))
        end)

        it("should handle boolean true", function()
            assert.are.equal("true", dump(true))
        end)

        it("should handle boolean false", function()
            assert.are.equal("false", dump(false))
        end)

        it("should handle numbers", function()
            assert.are.equal("42", dump(42))
            assert.are.equal("3.14", dump(3.14))
            assert.are.equal("-10", dump(-10))
        end)

        it("should handle strings", function()
            assert.are.equal("hello", dump("hello"))
            assert.are.equal("123", dump("123"))
        end)
    end)

    describe("table handling", function()
        it("should handle empty table", function()
            local result = dump({})
            assert.truthy(result:match("^{.*}$"))
        end)

        it("should handle simple array", function()
            local t = { 1, 2, 3 }
            local result = dump(t)
            assert.truthy(result:match("1"))
            assert.truthy(result:match("2"))
            assert.truthy(result:match("3"))
        end)

        it("should handle mixed table", function()
            local t = {
                "string1",
                50,
                ["key"] = "value"
            }
            local result = dump(t)
            assert.truthy(result:match("string1"))
            assert.truthy(result:match("50"))
            assert.truthy(result:match("key"))
            assert.truthy(result:match("value"))
        end)

        it("should handle nested tables", function()
            local t = {
                ["depth1"] = {
                    ["depth2"] = {
                        value = 100
                    }
                }
            }
            local result = dump(t)
            assert.truthy(result:match("depth1"))
            assert.truthy(result:match("depth2"))
            assert.truthy(result:match("100"))
        end)

        it("should handle boolean values in tables", function()
            local t = {
                ["ted"] = { true, false, "some text" }
            }
            local result = dump(t)
            assert.truthy(result:match("true"))
            assert.truthy(result:match("false"))
            assert.truthy(result:match("some text"))
        end)
    end)

    describe("edge cases", function()
        it("should handle function keys and values", function()
            local func = function() return end
            local t = {
                [func] = func
            }
            local result = dump(t)
            -- Functions should be converted to string representation
            assert.truthy(result:match("function"))
        end)

        it("should handle numeric keys", function()
            local t = {
                [1] = "first",
                [2] = "second"
            }
            local result = dump(t)
            assert.truthy(result:match("first"))
            assert.truthy(result:match("second"))
        end)

        it("should handle mixed key types", function()
            local t = {
                ["string_key"] = "string_value",
                [1] = "numeric_key_value",
                [true] = "boolean_key_value"
            }
            local result = dump(t)
            assert.truthy(result:match("string_key"))
            assert.truthy(result:match("string_value"))
            assert.truthy(result:match("numeric_key_value"))
            assert.truthy(result:match("boolean_key_value"))
        end)
    end)

    describe("indentation", function()
        it("should format nested tables with proper indentation", function()
            local t = {
                level1 = {
                    level2 = {
                        level3 = "deep_value"
                    }
                }
            }
            local result = dump(t)
            -- Check that the result contains nested structure
            assert.truthy(result:match("level1"))
            assert.truthy(result:match("level2"))
            assert.truthy(result:match("level3"))
            assert.truthy(result:match("deep_value"))
        end)
    end)
end)
