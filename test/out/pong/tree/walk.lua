local function walk_tree(root, f, custom_iterator)
  local function walk(iterfn, parent, idx, node)
    if f(idx, node, parent) then
      for k, v in iterfn(node) do
        walk(iterfn, node, k, v)
      end
      return nil
    end
  end
  walk((custom_iterator or pairs), nil, nil, root)
  return root
end
return walk_tree