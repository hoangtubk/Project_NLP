---
--- Created by tuhoangbk.
--- DateTime: 10/11/2017 10:14
---

class = require('pl.class')

---@class
Dictionary = class()
function Dictionary:_init()
    self._dict = {}
end

---@param word string
---@return boolean true if word is nil or "" and else
function Dictionary:word_is_nil(word)
    if word == nil or word == "" then

        return true
    end

    return false
end
---@param word string
---@return boolean
function Dictionary:is_word_in_dict(word)
    for k, v in pairs(self._dict) do
        if v == word then

            return true
        end
    end
    --print('tu nay chua co trong tu dien')
    return false
end

---@param word string
---@return boolean true if success and else
function Dictionary:add_word(word)
    if self:word_is_nil(word) then

        return false
    end
    if self:is_word_in_dict(word) == false then
        table.insert(self._dict, word)
    end

    return true
end

---@param old_word string
---@param new_word string
---@return void
function Dictionary:edit_word(old_word, new_word)
    if self:is_word_in_dict(old_word) == false and
        self:word_is_nil(new_word) then

        return
    end

    for k, v in pairs(self._dict) do
        if v == old_word then
            self._dict[k] = new_word
        end
    end

    return
end

---@param word string
function Dictionary:delete_word(word)
    if self:is_word_in_dict(word) == false then

        return
    end
    print('co')
    for k, v in pairs(self._dict) do
        if v == word then
            table.remove(self._dict, k)
        end
    end
end

---@param file_name string
function Dictionary:save_dict(file_name)
    torch.save(file_name, self._dict)
end

---@param file_name string
---@return table
function Dictionary:load_dict(file_name)

    return torch.load(file_name)
end

---@return table
function Dictionary:get_dict()

    return self._dict
end

---@return number
function Dictionary:get_dict_size()

    return #self._dict
end

--test = Dictionary()
--test:add_word("ahihi")
--test:add_word("do cho")
--test:delete_word('ahuhi')
--test:edit_word('do cho', 'do meo')
--print(test:get_dict())

