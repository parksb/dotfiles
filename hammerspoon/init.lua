do -- Remap Caps Lock to F19
    local remapper = require('foundation_remapping').new()
    remapper:remap('capslock', 'F19')
    remapper:register()
end
