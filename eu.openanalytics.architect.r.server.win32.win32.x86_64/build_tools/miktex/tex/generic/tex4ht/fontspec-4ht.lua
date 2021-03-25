-- fontspec-4ht.lua (2019-06-18-15:43), generated from tex4ht-4ht.tex
-- Copyright 2016-2019 TeX Users Group
--[[
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either
% version 1.3c of this license or (at your option) any
% later version. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions
% of LaTeX version 2005/12/01 or later.
%
% This work has the LPPL maintenance status "maintained".
%
% The Current Maintainer of this work
% is the TeX4ht Project <http://tug.org/tex4ht>.
%
% If you modify this program, changing the
% version identification would be appreciated.
\immediate\write-1{version 2019-06-18-15:43}

--]]
local M = {}

local glyph_id = node.id "glyph"
local whatsit_id = node.id "whatsit"
local special_subtype = node.subtype "special"
local dir_id = node.id "dir"
local glue_id = node.id "glue"

local escape = function(char)
  -- prepare tex4ht special for entity with unicode value
  return string.format("t4ht@+&{35}x%x{59}", char)
end

local make_node = function(data)
  -- make special whathsit
  local n = node.new(whatsit_id,special_subtype)
  n.data = data
  return n
end

local function first_node(head)
  local head = head
  while head.prev do
    head = head.prev
  end
  return head
end

-- this should be table with patterns for allowed fonts
local allowed_names = {"^cmr", "^cmb","^cmt", "^cmb", "^cmcs", "^rm%-l", "^cmi", "^ec%-lm", "none"}

local testfont = function(name)
  -- test font name for all allowed names, when it is found, return true
  for _, x in ipairs(allowed_names) do
    local r = name:match(x)
    if r then
      return true
    end
  end
  return false
end

local fonttypes = {}
local get_font_type = function(id)
  if fonttypes[id]~=nil then return fonttypes[id] end
  local f = font.getfont(id) or {name = "none"} -- font object can be nil sometimes
  local name = f.name
  local type = testfont(string.lower(name))
  if not type then
    print("Unsupported font",  name)
  end
  fonttypes[id] = type
  return type
end

local xchar = string.byte("x")

local utfchar = unicode.utf8.char
function M.char_to_entity(head)
  -- traverse characters
  for n in node.traverse(head) do
    if n.id == glyph_id then
      -- we need to process only default text font, ie cmr, because user may request special mathematical fonts,
      -- which should be processed via htf files as usual
      local t = get_font_type(n.font)
      if t == true then
        local char = n.char
        if char > 127 then
          local new = escape(char)
          local x = make_node(new)
          -- insert tex4ht special before char, it will replace the char
          node.insert_before(head, n, x)
          -- in standard tex4ht accented characters are replaced with "x" char. they are later removed anyway
          -- maybe we don't need to do that, but we can, so why not?
          n.char = xchar
        end
      end
    elseif n.id == dir_id then
      -- when text direction is TRT, the spaces in the DVI file have negative width and they are not recognized by tex4ht
      -- so we just change the direction to normal TLT
      n.dir = "+TLT"
    end
  end
  return first_node(head)
end

M.allowed = allowed_names

return M

