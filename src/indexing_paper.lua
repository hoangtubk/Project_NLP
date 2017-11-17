---
--- Created by tuhoangbk.
--- DateTime: 16/11/2017 17:42
---

include('pl_utils.lua')
include('dictionary.lua')
include('tokenizer.lua')

local utils = Utils()
local dict = Dictionary()
local tknz = Tokenizer()

local path_data = '../data'
local path_data_clean = '../data_clean'
local path_index = '../index'
local list_path_data = utils:find_file(path_data)

dict:load_dict('dictionary.t7')

--- Doc tung file trong moi chu de sau do tach tu, luu vao /index/
for k_data, v_data in pairs(list_path_data) do
    print(type(v_data))
    local path_data_subj = path_data ..'/'.. v_data
    local list_path_data_subj = utils:find_file(path_data_subj)
    for k_subj, v_subj in pairs(list_path_data_subj) do
        local content = utils:read_file(path_data_subj .. '/' .. v_subj)
        local list_token = tknz:split_word(content)
        local all_token = ''
        local all_index = ''
        for i = 2, #list_token do
            all_token = (all_token) .. (list_token[i]) .. ' '
            local id = dict:get_index_by_word(list_token[i])
            all_index = all_index .. id .. ' '
        end
        utils:write_file(path_data_clean .. '/' .. v_data .. '/' .. v_subj, all_token)
        utils:write_file(path_index .. '/' .. v_data .. '/' .. v_subj, all_index)
    end
end