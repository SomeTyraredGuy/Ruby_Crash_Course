require 'date'

class Student
  @@students = []
  attr_accessor :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    Student.validate_date_of_birth date_of_birth

    @surname = surname
    @name = name
    @date_of_birth = date_of_birth
    Student.add_student self
  end

  def self.validate_date_of_birth(date_of_birth)
    raise ArgumentError, "Argument date_of_birth must be Date, not #{date_of_birth.class}" unless date_of_birth.is_a?(Date)

    raise ArgumentError, "Argument date_of_birth must be in the past" if date_of_birth >= Date.today
  end

  def calculate_age
    today = Date.today
    
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth.next_year(age)

    age
  end

  def self.add_student(student)
    return false unless Student.find(student.surname, student.name, student.date_of_birth) == nil

    @@students << student
    true
  end

  def self.remove_student(surname, name, date_of_birth)
    found_student = Student.find(surname, name, date_of_birth)
    return false if found_student == nil
    
    @@students.delete found_student
    true
  end

  def self.find(surname, name, date_of_birth)
    @@students.find{ |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select{ |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select{ |student| student.name == name }
  end

end