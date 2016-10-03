arr = [{:name=>:deepak, :id=>1}, {:name=>:ajay, :id=>2}, {:name=>:deepak, :id=>1}]
arr_new = []

arr.each do |element|
  arr_new << element unless arr_new.include?(element)
end

puts arr_new