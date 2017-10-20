local bit32 = require("bit32")

local binary = {}

---Converts an integer into a little endian byte array or a given size, defaults to 4 bytes if ommited
---@param int number
---@param optional length number
---@return table
function binary.int2bytes(int, length)
    length = length or 4
    local result = {}
    for i = 1, length do
        result[i] = bit32.band(bit32.rshift(int, ((i-1) * 8)), 0xFF)
    end
    return result
end

---Converts a little endian byte array into a binary string
---@param bytes table
---@return string
function binary.bytes2string(bytes)
    return string.char(table.unpack(bytes))
end

---Converts an integer into a little endian binary string of a given size, defaults to 4 bytes if ommited
---@param int number
---@param optional length number
---@return string
function binary.int2binString(int, length)
    return binary.bytes2string(binary.int2bytes(int, length))
end

---Converts a binary string into a byte array
---@param str string
---@return table
function binary.binString2bytes(str)
    local result = {}
    for i = 1, string.len(str) do
        result[i] = string.byte(str, i)
    end
    return result
end

---Converts a byte array of a little endian integer into an integer
---@param bytes table
---@return number
function binary.bytes2int(bytes)
    local result = 0
    for i, v in ipairs(bytes) do
        result = result + bit32.lshift(v, (i-1) * 8)
    end
    return result
end

---Converts a binary string of a little endian integer into a integer
---@param bytes table
---@return number
function binary.string2int(str)
    return binary.bytes2int(binary.string2bytes(str))
end

---Converts a binary string of a little endian integer into a integer
---@param bytes table
---@return number
function binary.binString2int(str)
    return binary.bytes2int(binary.string2bytes(str))
end

local function debug()
    local serial = require("serialization")
    print(serial.serialize(binary.int2bytes(384)))
    local test = binary.int2binString(384)
    print(test)
    test = binary.binString2bytes(test)
    print(serial.serialize(test))
    print(binary.bytes2int(test))
  end

return binary
