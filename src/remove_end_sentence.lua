---
--- Created by tuhoangbk.
--- DateTime: 16/11/2017 10:22
---

--- module này để loại bỏ phần thừa ở cuối mỗi bài báo:
---     + Tên tác giả
---     + Địa chỉ
---     + Số điện th
include('pl_utils.lua')
include('tokenizer.lua')

local ut = Utils()
local tknz = Tokenizer()

---find file
local path_all = '../data/xe_/'
local new_path = '../data/xe/'
local paths = ut:find_file(path_all)
--print(paths)
for k, v in pairs(paths) do
    print(v)
    local content = ut:read_file(path_all .. v)
    local  xx = tknz:split_word_only(content, 'f.#')
    local str = ''
    for i = 1, #xx - 13, 1 do
        str = str ..'.'.. xx[i]
    end
    ut:write_file(new_path .. v, str)
end



