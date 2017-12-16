---
--- Created by tuhoangbk.
--- DateTime: 16/11/2017 17:42
---

utf8 = require 'lua-utf8'
include('pl_utils.lua')
include('dictionary.lua')
include('tokenizer.lua')
class = require('pl.class')
---@class
Process_Paper = class()
---Init class
function Process_Paper:_init()
    self.utils = Utils()
    self.dict = Dictionary()
    self.tknz = Tokenizer()
end

--- Loại bỏ các kí tự thừa trong các bài báo, thay thế số bằng <number>
---@param path_input string @ path of raw paper
---@param path_output string @ path of new paper
function Process_Paper:clean(path_input, path_output)
    local paths = self.utils:find_file(path_input)
    for i = 1, #paths do
        local files = self.utils:find_file(path_input .. '/' .. paths[i])
        for j = 1, #files do
            local string_token = ''
            local content = self.utils:read_file(path_input .. '/' .. paths[i] .. '/' .. files[j])
            local tokens = self.tknz:split_word(content)
            --- k = 2 bỏ đi kí tự nil đầu table
            for k = 2, #tokens do
                string_token = string_token .. tokens[k] .. ' '
            end
            string_token = utf8.gsub(string_token, 'xxxxx', '_') ---replace 'xxxxx' by '\n'
            self.utils:write_file(path_output .. '/' .. paths[i] .. '/' .. files[j], string_token)
        end
    end
end

---Biểu diễn mỗi bài báo dưới dạng vector 1*n
--- Trong đó n là độ dài của bài báo
--- Lưu ý: có trường hợp index = -1
function Process_Paper:indexing(path_input, path_output)
    self.dict:load_dict('dictionary.t7')
    local paths = self.utils:find_file(path_input)
    local label = 0
    for i = 1, #paths do
        if(paths[i] == 'newspaper') then
            goto continue
        end
        label = label + 1
        local files = self.utils:find_file(path_input .. '/' .. paths[i])
        for j = 1, #files do
            local string_index = ''
            string_index = string_index .. tostring(label) ..'|'
            local content = self.utils:read_file(path_input .. '/' .. paths[i] .. '/' .. files[j])
            local tokens = self.tknz:split_word(content)
            --- k = 2 bỏ đi kí tự nil đầu table
            for k = 2, #tokens do
                local id = self.dict:get_index_by_word(tokens[k])
                string_index = string_index .. id .. ' '
            end
            self.utils:write_file(path_output .. '/' .. paths[i] .. '/' .. files[j], string_index)
            self.utils:write_file(path_output .. '/' .. 'newspaper' .. '/' .. files[j], string_index)
        end
        ::continue::
    end
end

--- Tính giá trị max của mỗi dòng
---@param string string
---@return number @max len
function Process_Paper:get_max_len_each_line(string)
    local str_array = self.tknz:split_word_only(string, "\n")
    local max = 0
    for i = 1, #str_array do
        if utf8.len(str_array[i]) > max then
            max = utf8.len(str_array[i])
        end
    end

    return max
end
--
--test = Process_Paper()
--local str = test.utils:read_file("test.txt")
--local arr = test:get_max_len_each_line(str)
--print(arr)
--test:indexing('../data', '../index')
