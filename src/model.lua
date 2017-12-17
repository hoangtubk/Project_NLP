---
--- Created by tuhoangbk.
--- DateTime: 19/11/2017 20:26
---

require('rnn')
require('nn')
include('dictionary.lua')
class = require('pl.class')

Model = class()
local dict = Dictionary()
--dict:load_dict('dictionary.t7')
function Model:_init()
    self.dict_size = dict:get_dict_size()
    self.hidden_size = 200
    self.batch_size = 256 -- số lượng câu trong mỗi input
    self.nout = 7 ---7 nhãn

end

function Model:build_brnn()
    local lt = nn.LookupTableMaskZero(self.dict_size, self.hidden_size)
    local brnn = nn.SeqBRNN(self.hidden_size, self.hidden_size, true) ---use true: batchsize x seqLen x inputsize
    brnn.forwardModule.maskzero = true
    brnn.backwardModule.maskzero = true
    local linear = nn.Sequencer(nn.MaskZero(nn.Linear(self.hidden_size, self.nout),1))
    local logsoftmax = nn.Sequencer(nn.MaskZero(nn.LogSoftMax(),1))
    ---build model
    local rnn = nn.Sequential()
    rnn:add(lt)
    rnn:add(brnn)
    rnn:add(linear)
    rnn:add(logsoftmax)
    return rnn
end

function Model:get_criterion_func()
    return self.criterion
end

function Model:build_seqbrnn()
    local seqlstm = ((nn.SeqLSTM(self.hidden_size, self.hidden_size)))
    local seqrever = ((nn.SeqReverseSequence(1)))
    local transpose = nn.Transpose({1, 2})

    local seqbrnn = nn.Sequential()
    local sequential = nn.Sequential()
    :add(seqrever)
    :add(seqlstm)
    :add(seqrever)
    local concattable = nn.ConcatTable()
    :add(seqlstm)
    :add(sequential)

    seqbrnn:add(transpose)
    :add(concattable)
    :add(nn.CAddTable())
    :add(transpose)

    return seqbrnn
end
--model = Model()
--local x = model:build_brnn()
--print(x)