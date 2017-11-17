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

local path_data = '../data_clean/newspaper/'
local space = nil

local all_paper = file:find_file(path_data)
for k, v in pairs(all_paper) do
    print(v)
    local content = file:read_file((path_data .. v))
    token_table = tknz:split_word_only(content, space)
    for k, v in pairs(token_table) do
        dict:add_word(v)
    end
end

--save_dict to file .t7
dict:save_dict('dictionary.t7')

print(dict:get_dict())
