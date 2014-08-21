Ohai.plugin(:Example1) do
  provides "awesome_level"
  collect_data do
    awesome_level 100
  end
end