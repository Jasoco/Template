local _rnd = math.random
local _flr = math.floor
local _cei = math.ceil
local _cos = math.cos
local _sin = math.sin
local _sqr = math.sqrt
local _at2 = math.atan2
local _d2r = math.rad
local _r2d = math.deg
local _mod = math.mod
local _max = math.max
local _min = math.min

local pi = math.pi

function distanceFrom(x1,y1,x2,y2) return _sq((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

function degToRad(d) return d * pi / 180 end

function sort(T) table.sort(T, function(a, b) return a.y < b.y end ) end

function formatNumber(number)
   return (string.format("%d", number):reverse():gsub( "(%d%d%d)" , "%1," ):reverse():gsub("^(-?),","%1"))
end

function overlap(x1,y1,w1,h1, x2,y2,w2,h2)
  return not (x1+w1 < x2  or x2+w2 < x1 or y1+h1 < y2 or y2+h2 < y1)
end

function inside(x1,y1, x2,y2,w2,h2)
  return not (x1 < x2  or x2+w2 < x1 or y1 < y2 or y2+h2 < y1)
end

function nextPO2(x)
    return 2 ^ math.ceil(math.log(x)/math.log(2))
end

function distanceFrom(x1,y1,x2,y2) return _sq((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

function findAngle(x1, y1, x2, y2)
	local t = _r2d(_at2(y1 - y2, x2 - x1))
	if t < 0 then t = t + 360 end
	return t
end

function formatTime(t, m)
  local r = _f(_m(t/60/60,60)) .. ":" .. string.sub("0" .. _f(_m(t/60,60)),-2) .. ":" .. string.sub("0" .. _f(_m(t,60)),-2)
  if m then r = r .. (t - _f(t)) end
  return r
end

function trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end

function rotate_point( cx, cy, ox, oy, angle )
  local rot_pnt = { x, y }
  rot_pnt.x = ox * _c(_d2r(-angle)) - oy * _s(_d2r(-angle))
  rot_pnt.y = ox * _s(_d2r(-angle)) + oy * _c(_d2r(-angle))
  return rot_pnt.x + cx, rot_pnt.y + cy
end

function intNoise()
  return ((math.random() * 2) - 1)
end
