---
--- Created by tuhoangbk.
--- DateTime: 10/11/2017 09:33
---
require('rnn')
require('nn')

include('pl_utils.lua')
include('dictionary.lua')
include('tokenizer.lua')
include('process_paper.lua')
include('training.lua')
include('model.lua')

---===================================================================
---Khởi tạo object
local utils = Utils()
local tknz = Tokenizer()
local dict = Dictionary()
local process_paper = Process_Paper()
local training = Training()
local model = Model()
---===================================================================
---Khởi tạo các tham số
local input_path_data = '../data_tknz'
local ouput_path_data = '../data_clean'
local path_data_all = '../data_clean/newspaper'
local path_data_index_all = '../data_index/newspaper'
local index_path_data = '../data_index'

local is_clean = false
local is_create_dict = true
local is_save_dict = true
local is_indexing = false
local is_training = false

local epochs = 50
local mlp = model:build_brnn()
print(mlp)
---===================================================================
--- Làm sach các bài báo
if is_clean then
    print('Cleaning')
    process_paper:clean(input_path_data, ouput_path_data)
end
---===================================================================
--- Khởi tạo từ điển
if is_create_dict then
    print('Creating dictionary')
    local papers = utils:find_file(path_data_all)
    for i = 1, 100 do
        local content = utils:read_file((path_data_all .. '/' .. papers[torch.random(#papers)]))
        local tokens = tknz:split_word_only(content, nil)
        for j = 1, #tokens do
            dict:add_word(tokens[j])
        end
    end
end
---===================================================================
--save_dict to file .t7
if is_save_dict then
    print(dict:get_dict())
    print('Save file dictionary')
    dict:save_dict('dictionary.t7')
end
---===================================================================
--- Đánh index cho mỗi bài báo
if is_indexing then
    print('Indexing')
    process_paper:indexing(ouput_path_data, index_path_data)
    print('OK')
end

---===================================================================
---Training
if is_training then
    print("Training")
    local list_news_name = utils:find_file(path_data_index_all)
    --local criterion = nn.SequencerCriterion(nn.MaskZeroCriterion(nn.ClassNLLCriterion(weight),1))
    local criterion = nn.SequencerCriterion(nn.MaskZeroCriterion(nn.ClassNLLCriterion(), 1))
    local learning_rate = 0.01
    for epoch = 1, epochs do
        print("epoch = "..tostring(epoch)..'/'..tostring(epochs))
        training:train(mlp, list_news_name, criterion, learning_rate)
    end
end