---
--- Created by tuhoangbk.
--- DateTime: 10/11/2017 09:33
---

include('pl_utils.lua')
include('dictionary.lua')
include('tokenizer.lua')

local file = Utils()
local tknz = Tokenizer()
local dict = Dictionary()

local path_data = '../data/all paper/'
local space = ' '

local all_paper = file:find_file(path_data)
for k, v in pairs(all_paper) do
    print(v)
    local content = file:read_file((path_data .. v))
    token_table = tknz:split_word(content, space)
    for k, v in pairs(token_table) do
        dict:add_word(v)
    end
end

dict:save_dict('dictionary.t7')

print(dict:get_dict())
