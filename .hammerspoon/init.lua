-- clone from https://github.com/naoya/hammerspoon-init
-- ref. [Karabiner 使えない対策: Hammerspoon で macOS の修飾キーつき
--      ホットキーのキーリマップを実現する]
--      (http://qiita.com/naoya@github/items/81027083aeb70b309c14)

require('watcher')

local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function keyCodeSet(keys)
   return function()
      for i, keyEvent in ipairs(keys) do
         keyEvent()
      end
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      name = string.lower(name)
      -- hs.alert.show(name)
      if name == "iterm2" or name == 'emacs' then
         disableAllHotkeys()
      else
         enableAllHotkeys()
      end
   end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- カーソル移動
remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl', 'shift'}, 'f', keyCode('right', {'shift'}))
remapKey({'ctrl', 'shift'}, 'b', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'n', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'p', keyCode('up', {'shift'}))
remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))

-- テキスト編集
remapKey({'ctrl'}, 'm', keyCode('return'))
remapKey({'ctrl', 'shift'}, 'm', keyCode('return', {'shift'}))
remapKey({'ctrl'}, 'i', keyCode('tab'))
remapKey({'ctrl', 'shift'}, 'i', keyCode('tab', {'shift'}))
remapKey({'ctrl'}, 'w', keyCode('x', {'cmd'}))
remapKey({'ctrl'}, 'y', keyCode('v', {'cmd'}))
remapKey({'ctrl'}, 'd', keyCode('forwarddelete'))
remapKey({'ctrl'}, 'h', keyCode('delete'))
remapKey({'ctrl'}, 'k', keyCodeSet({
  keyCode('right', {'cmd', 'shift'}), 
  keyCode('x', {'cmd'})
}))

-- コマンド
remapKey({'ctrl'}, 's', keyCode('f', {'cmd'}))
remapKey({'ctrl'}, '/', keyCode('z', {'cmd'}))
remapKey({'ctrl'}, 'g', keyCode('escape'))

-- ページスクロール
remapKey({'ctrl'}, 'v', keyCode('pagedown'))
remapKey({'alt'}, 'v', keyCode('pageup'))
remapKey({'cmd', 'shift'}, ',', keyCode('home'))
remapKey({'cmd', 'shift'}, '.', keyCode('end'))

-- numpad
remapKey({'alt'}, 'm', keyCode('1'))
remapKey({'alt'}, ',', keyCode('2'))
remapKey({'alt'}, '.', keyCode('3'))
remapKey({'alt'}, 'j', keyCode('4'))
remapKey({'alt'}, 'k', keyCode('5'))
remapKey({'alt'}, 'l', keyCode('6'))
remapKey({'alt'}, 'u', keyCode('7'))
remapKey({'alt'}, 'i', keyCode('8'))
remapKey({'alt'}, 'o', keyCode('9'))
remapKey({'alt'}, 'n', keyCode('0'))
