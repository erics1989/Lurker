abstraction = {}

function abstraction.print(str, x, y)
    love.graphics.print(str, x, y)
end

function abstraction.font_w(font, str)
    return font:getWidth(str or "a")
end

function abstraction.font_h(font)
    return font:getHeight()
end

function abstraction.draw(a, b, c, d)
    love.graphics.draw(a, b, c, d)
end

function abstraction.set_color(a, b, c)
    love.graphics.setColor(a, b, c)
end

