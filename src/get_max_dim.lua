---
--- Created by tuhoangbk.
--- DateTime: 16/12/2017 21:35
---

include('pl_utils.lua')
include('tokenizer.lua')

local utils = Utils()
local tknz = Tokenizer()

local path_news = '../data_index/newspaper/'
local list_file =  utils:find_file(path_news)

local max_dim = 0
local max_file = ''
local count = 0
for i = 1, #list_file do
    local data_file = utils:read_file(path_news .. list_file[i])
    data_file = tknz:split_word_only(data_file)
    --print(#data_file)
    --print(list_file[i])
    if #data_file > max_dim then
        max_dim = #data_file
        max_file = list_file[i]
    end
    if #data_file > 1000 then
        count = count + 1
    end
end
print(max_dim)
print(max_file)
print(count)