---
--- Created by tuhoangbk.
--- DateTime: 19/11/2017 20:26
---

require('nn')
require('rnn')
--require('cutorch')
--require('cunn')
class = require('pl.class')

include('pl_utils.lua')
include('testing.lua')
include('tokenizer.lua')

local testing = Testing()
local path_all_news = '../data_index/newspaper/'

---@class Training
Training = class()

---init Training
function Training:_init()
    self.utils = Utils()
    self.tknz = Tokenizer()
    ---model save after each n loop
    self.n_save = 50
    self.loop_train = 50
    self.train_size = 57057
    self.batch_size = 256
    self.max_len = 10000
    self.use_cuda = false
end

---@param table_inputs table
---@param table_targets table
---@param criterion
---@param learning_rate number
---@param input_from number
---@param input_to number
function Training:train(model,list_file_input, criterion, learning_rate)
    ---use GPU with cuda
    if self.use_cuda then
        criterion = criterion:cuda()
        model = model:cuda()
    end
    --- setup learning_rate
    local lr_reduction = (learning_rate - 0.001)/self.loop_train
    ---begin training
    local iteration = 0
    local timer = torch.Timer()
    while iteration < self.loop_train do
        iteration = iteration +1
        if iteration % self.n_save == 0 then
            torch.save('seqbnn' .. iteration ..'.t7', model)
        end
        learning_rate = learning_rate - lr_reduction
        local  err, sum_err, precision = 0, 0, 0
        local grad_ouputs = {}

        for step = 1, math.floor(self.train_size/self.batch_size) do
            ---=========================================================================================================
            ---create input & target
            local input_tensor = torch.Tensor(self.batch_size, self.max_len)
            local target_tensor = torch.Tensor(self.batch_size)
            for i = 1, self.batch_size do
                local data_train = self.utils:read_file(path_all_news .. list_file_input[torch.random(#list_file_input)])
                data_train = self.tknz:split_word_only(data_train, '|')
                if(data_train[2] == nil) then
                    goto _continue
                end
                local inp = self.tknz:split_word_only(data_train[2])
                local tar = data_train[1]
                for j = 1, #inp do
                    input_tensor[i][j] = inp[j]
                end
                target_tensor[i] = tar
                ::_continue::
            end
            --print(input_tensor)
            --print(target_tensor)
            ---=========================================================================================================
            if self.use_cuda then
                input_tensor = input_tensor:cuda()
                target_tensor = target_tensor:cuda()
            end
            local output = model:forward(input_tensor)
            model:zeroGradParameters()
            err = criterion:forward(output, target_tensor)
            grad_ouputs[step] = criterion:backward(output, target_tensor)
            model:backward(input_tensor, grad_ouputs[step])
            model:updateParameters(learning_rate)
            sum_err = sum_err + err
        end
        ---compute precision and print result
        --if (iteration % 5) == 0 then
        --    precision = testing:test(model, inputs, targets)
        --end
        print(learning_rate)
        print(string.format("Iteration %d / ".. self.loop_train .." ; Error = %f, Precision = %f ", iteration, sum_err, precision))
        ---Training is finished:
        --if sum_err < 1 then
        --    break
        --end
    end
    print('Time training:' .. timer:time().real .. ' seconds')
end
