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
point = {x = 0, y = 0}
vector = {point, point}

function angle(v)
    return math.atan2(v[2].y - v[1].y, v[2].x - v[1].x)
end

function magnitude(v)
    return math.sqrt((v[1].x -v[2].x)^2 + (v[1].y - v[2].y)^2)
end

function pointExtend(p, a, m)
    return  {x = math.cos(a) * m + p.x, y = math.sin(a) * m + p.y}
end

function trim(max, v)
    a = angle(v)
    m = rangeCap(magnitude(v), max)
    return {v[1], pointExtend(v[2], a, m)}
end

function pointAdd(p1, p2)
    return {x = p1.x + p2.x, y = p1.y + p2.y}
end

function pointSub(p1, p2)
    return {x = p1.x - p2.x, y = p1.y - p2.y}
end

function pointCross(p1, p2)
    return (p1.x * p2.y) - (p1.y * p2.x)
end


function intersect(v1, v2)
    a = cross(pointSub(v1[1], v2[1]), v2[2])
    b = cross(pointSub(v2[1], v1[1]))
    c = cross(v1[2], v2[2])
    --lines are parallel
    if c == 0 then
        --and are colinear
        if b == 0 then
            --I don't think I really need to know the lengths, so probably just return the averaged center between the overlapping portion
            return true
        --but don't intersect
        else
            return false
        end
    --lines are not parallel
    else
        --and intersect at
        if then
            --return the point of intersection
            return true
        --but don't intersect
        else
            return false
    end
    
    t = a/c
    u = b/c
end
