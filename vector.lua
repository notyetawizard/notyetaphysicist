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
pointZero = {x = 0, y = 0}
vectorZero = {pointZero, pointZero}

function angle(v)
    return math.atan2(v[2].y - v[1].y, v[2].x - v[1].x)
end

function magnitude(v)
    return math.sqrt((v[2].x - v[1].x)^2 + (v[2].y - v[1].y)^2)
end

function pointExtend(p, a, m)
    return  {x = math.cos(a) * m + p.x, y = math.sin(a) * m + p.y}
end

function pointOrder(points)
    local list = {}
    for pk, pv in ipairs(points) do
        local pm = magnitude({pointZero, pv})
        local check = false
        for lk, lv in ipairs(list) do
            lm = magnitude({pointZero, lv})
            if pm <= lm then
                table.insert(list, lk, pv)
                check = true
                break 
            end
        end
        if check == false then
            table.insert(list, pv)
        end
    end
    return list
end

function trim(max, v)
    a = angle(v)
    m = rangeCap(magnitude(v), max)
    return {v[1], pointExtend(v[2], a, m)}
end

function add(p1, p2)
    return {x = p1.x + p2.x, y = p1.y + p2.y}
end

function sub(p1, p2)
    return {x = p1.x - p2.x, y = p1.y - p2.y}
end

function mul(p1, p2)
    return {x = p1.x * p2.x, y = p1.y * p2.y}
end

function cross(p1, p2)
    return (p1.x * p2.y) - (p1.y * p2.x)
end


function intersect(v1, v2)
    --http://stackoverflow.com/a/565282
    --t = (q − p) × s / (r × s)
    --u = (q − p) × r / (r × s)

    local p, r = v1[1], sub(v1[2], v1[1])
    local q, s = v2[1], sub(v2[2], v2[1])
    local rxs = cross(r, s)
    local qpxs = cross(sub(q, p), s)
    local qpxr = cross(sub(q, p), r)
    
print("--\n") 
    if rxs == 0 then
print(rxs, "lines are parallel")
    --lines are parallel
        if qpxr == 0 then
print(qpxr, "and are colinear")
        --and are colinear
            --I don't think I really need to know the lengths, so probably just return the averaged center between the overlapping portion
            
            --order points by distance from origin, average the center two.
            return true
        else
print(qpxr, "but don't intersect")
        --but don't intersect
            return false
        end
    else
print(rxs, "lines are not parallel")
    local t, u = qpxs/rxs, qpxr/rxs
    --lines are not parallel
        if (0 <= t and t <= 1) and (0 <= u and u <= 1) then
print(t, u, "and intersect")
        --and intersect at
equivilent = add(q, mul(s, {x = u, y = u}))
print(equivilent.x, equivilent.y, "at")
            return true, add(p, mul(r, {x = t, y = t}))
        else
print(t, u, "but don't intersect")
        --but don't intersect
            return false
        end
    end    
end

--test cases!
--from https://martin-thoma.com/how-to-check-if-two-line-segments-intersect/

--lines are perpendic3ular
--intersect({{x = 0, y = 1}, {x = 2, y = 1}}, {{x = 1, y = 0}, {x = 1, y = 2}})

--lines are parallel, but don't touch
--intersect({{x = 2, y = 2}, {x = 8, y = 2}}, {{x = 4, y = 4}, {x = 6, y = 4}})
--intersect({{x = 6, y = 8}, {x = 8, y = 10}}, {{x = 4, y = 4}, {x = 12, y = 12}})
--intersect({{x = -8, y = 8}, {x = -4, y = 2}}, {{x = -4, y = 6}, {x = 0, y = 0}})
--intersect({{x = 0, y = 0}, {x = 0, y = 2}}, {{x = 4, y = 4}, {x = 4, y = 6}})
--intersect({{x = 0, y = 0}, {x = 0, y = 2}}, {{x = 4, y = 4}, {x = 6, y = 4}})


--lines are colinear 
--intersect({{x = 0, y = 0}, {x = 8, y = 0}}, {{x = 2, y = 0}, {x = 6, y = 0}})

--colinear, line 1 is just a point.
--intersect({{x = 0, y = 0}, {x = 0, y = 0}}, {{x = 0, y = 0}, {x = 6, y = 0}})

--colinear, disjoint
--FAILED! Need to check lengths and such too!
intersect({{x = -2, y = -2}, {x = 4, y = 4}}, {{x = 6, y = 6}, {x = 10, y = 10}})


--line2 starts on line1
--intersect({{x = 0, y = 0}, {x = 10, y = 10}}, {{x = 2, y = 2}, {x = 16, y = 4}})
--intersect({{x = 0, y = 4}, {x = 4, y = 4}}, {{x = 4, y = 8}, {x = 4, y = 0}})

--negative values, perpendicular
--intersect({{x = 0, y = 0}, {x = -2, y = 0}}, {{x = -2, y = -2}, {x = -2, y = 2}})

--lines don't intersect
--intersect({{x = 0, y = 0}, {x = 2, y = 2}}, {{x = 0, y = 4}, {x = 1, y = 4}})
--intersect({{x = 0, y = 8}, {x = 10, y = 0}}, {{x =4, y = 2}, {x = 4, y = 4}})
