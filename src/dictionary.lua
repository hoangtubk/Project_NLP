---
--- Created by tuhoangbk.
--- DateTime: 10/11/2017 10:14
---

class = require('pl.class')

---@class Dictionary
Dictionary = class()
function Dictionary:_init()
    self._dict = {'ahihi'}
    self._dict_size = {}
    print(self._dict)
end

function Dictionary:add_word()

end

function Dictionary:edit_word()

end

function Dictionary:delete_word()

end

function Dictionary:save_dict()

end

function Dictionary:load_dict()

end

function Dictionary:get_dict()

end

function Dictionary:get_dict_size()

end
test = Dictionary()