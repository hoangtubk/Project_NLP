---
--- Created by tuhoangbk.
--- DateTime: 10/11/2017 10:15
---

class = require('pl.class')
model = class()

function model:_init()
    self._model_rnn = nil
    self._model_cnn = nil
end

function model:build_cnn()
    local net = nn.Sequential()
    net:add(nn.Linear(16*5*5, 120))
    net:add(nn.ReLU())
    net:add(nn.Linear(120, 84))
    net:add(nn.ReLU())
    net:add(nn.Linear(84, 10))
    net:add(nn.LogSoftMax())
    self._model_cnn = net
end

function model:build_rnn()
    local r = nn.Recurrent(
        hiddenSize, nn.LookupTable(nIndex, hiddenSize),
        nn.Linear(hiddenSize, hiddenSize), nn.Sigmoid(),
        rho
    )
    local rnn = nn.Sequential()
        :add(r)
        :add(nn.Linear(hiddenSize, nIndex))
        :add(nn.LogSoftMax())
    rnn = nn.Recursor(rnn, rho)
    self._model_rnn = rnn
end

function model:get_cnn()

    return self._model_cnn
end

function model:get_rnn()

    return self._model_rnn
end