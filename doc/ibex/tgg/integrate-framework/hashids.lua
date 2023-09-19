function Link (el)
    if el.target and string.gmatch(el.target, 'md$') then
        el.target = '#' .. el.target
    end
    return el
end
