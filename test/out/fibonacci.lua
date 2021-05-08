local function fibonacci(n)
  if (n < 2) then
    return n
  else
    return (fibonacci((n - 1)) + fibonacci((n - 2)))
  end
end
return print(fibonacci(10))