require_relative 'student.rb'

s1 = Student.new "Smith", "Ethan", Date.new(2003,5,4)
s2 = Student.new "Brown", "William", Date.new(2003,5,4)
s3 = Student.new "Martinez", "Emily", Date.new(2005,6,20)

begin
  s4 = Student.new "Miller", "Jacob", "some text"
rescue ArgumentError => e
  puts e.message
end

begin
  s5 = Student.new "Davis", "Mia", Date.new(2025,11,23)
rescue ArgumentError => e
  puts e.message
end

puts "\nget_students_by_name 'William':"
p Student.get_students_by_name "William"

puts "\ncalculate_age:"
puts "s1 = #{s1.calculate_age}"
puts "s2 = #{s2.calculate_age}"

puts "\nremove s1: #{Student.remove_student("Smith", "Ethan", Date.new(2003,5,4))}"

puts "\nget_students_by_age 21:"
p Student.get_students_by_age 21

puts "\nadd_student s1: #{Student.add_student s1}"

s4 = Student.new "Smith", "Ethan", Date.new(2003,5,4)
puts "\nadd duplicate: #{Student.add_student s4}"
