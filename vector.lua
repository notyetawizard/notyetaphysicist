vector = {}

--Cap number if outside a range
function rangeCap(n, h, l)
    if n > h then return h
    elseif n < (l or -h) then return (l or -h)
    else return n
    end
end

--Wrap number if outside a range
function rangeWrap(n, h, l)
    if n > h then return (l or -h)
    elseif n < (l or -h) then return (l or h)
    else return n
    end
end

--Vectors and points are to be passed as tables;
vector.point = {x = 0, y = 0}
vector.vector = {vector.point, vector.point}

function vector.angle(v)
    return math.atan2(v[2].y - v[1].y, v[2].x - v[1].x)
end

function vector.magnitude(v)
    return math.sqrt((v[1].x -v[2].x)^2 + (v[1].y - v[2].y)^2)
end

function vector.endPoint(p, a, m)
    return  {x = math.cos(a)*m + p.x, y = math.sin(a)*m + p.y}
end

function vector.trim(max, v)
    a = vector.angle(v)
    m = rangeCap(vector.magnitude(v), max)
    return {v[1], vector.endPoint(v[2], a, m)}
end

return vector
