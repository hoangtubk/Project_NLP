---
--- Created by tuhoangbk.
--- DateTime: 16/12/2017 10:12
---

include('pl_utils.lua')
include('tokenizer.lua')

local utils = Utils()
local tknz = Tokenizer()
local path_name = '/home/tuhoangbk/ZaloHackathon/output/category.txt'
local path_name_hashcode = '/home/tuhoangbk/ZaloHackathon/output/name_hashcode.txt'
local content_hash = ''

local lines = utils:read_file(path_name)
local line_table = tknz:split_word_only(lines, '\n')

for i = 1, #line_table do
    if(line_table[i] == "phu-kien") then
        local str = "phụ kiện"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "sac-dtdd") then
        local str = "sạc điện thoại di động"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "cap-dien-thoai") then
        local str = "cáp điện thọai di "
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "the-nho-dien-thoai") then
        local str = "thẻ nhớ điện thoại di động"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "tai-nghe") then
        local str = "tai nghe"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "usb") then
        local str = "usb"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "chuot-may-tinh") then
        local str = "chuột máy tính"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "loa-laptop") then
        local str = "loa laptop"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "phu-kien-chinh-hang") then
        local str = "phụ kiện chính hãng"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "phu-kien-khac") then
        local str = "phụ kiện khác"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "op-lung-dien-thoai") then
        local str = "ốp lưng điện thoại"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "Điện thoại") then
        local str = "điện thoại"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "Laptop") then
        local str = "laptop"
        content_hash = content_hash .. str .. '\n'
    end
    if(line_table[i] == "Máy tính bảng") then
        local str = "máy tính bảng"
        content_hash = content_hash .. str .. '\n'
    end
end
utils:write_file(path_name_hashcode, content_hash)