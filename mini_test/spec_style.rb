#require "minitest/autorun"
require "minitest/spec"
require_relative 'test_helper'
require_relative '../app/student'


describe Student do
  before do
    @student = Student.new("Surname", "Name", Date.new(Date.today.year, Date.today.month, Date.today.day - 1))
  end

  after do
    Student.remove_student @student.surname, @student.name, @student.date_of_birth
    @student = nil
  end

  describe "#calculate_age" do
    it "must return Integer" do
      expect(@student.calculate_age).must_be_instance_of Integer
    end
  
    it "must be equal 0 if the student's date of birth is set to yesterday" do
      expect(@student.calculate_age).must_equal 0
    end
  end

  describe "#add_student" do
    it "must return false when student already in list" do
      expect(Student.add_student(@student)).must_equal false 
    end
    
    it "must return true when student is not on a list" do
      Student.remove_student @student.surname, @student.name, @student.date_of_birth
      expect(Student.add_student(@student)).must_equal true
      expect(Student.find(@student.surname, @student.name, @student.date_of_birth)).must_equal @student
    end
  end

  describe "#remove_student" do
    it "must return true when student is in list" do
      expect(Student.remove_student(@student.surname, @student.name, @student.date_of_birth)).must_equal true 
    end
    
    it "must return false when student is not on a list" do
      expect(Student.remove_student(@student.surname, @student.name, @student.date_of_birth)).must_equal true
      expect(Student.find(@student.surname, @student.name, @student.date_of_birth)).must_be_nil
    end
  end
  
  describe "#find" do
    it "must return Student when found" do
      expect(Student.find(@student.surname, @student.name, @student.date_of_birth)).must_be_instance_of Student
    end

    it "must return student with described parameters" do
      expect(Student.find(@student.surname, @student.name, @student.date_of_birth)).must_be_same_as @student
    end

    it "must return nil when student is not on a list" do
      Student.remove_student @student.surname, @student.name, @student.date_of_birth
      expect(Student.find(@student.surname, @student.name, @student.date_of_birth)).must_be_nil
    end
  end
  
  describe "#get_student_by_age" do
    it "must return empty collection when no student found" do
      expect(Student.get_students_by_age(Date.today)).must_be_empty 
    end

    it "must return collection with matching students" do
      expect(Student.get_students_by_age(@student.calculate_age)).must_include @student
    end
  end

  describe "#get_student_by_name" do
    it "must return empty collection when no student found" do
      expect(Student.get_students_by_name("")).must_be_empty 
    end

    it "must return collection with matching students" do
      expect(Student.get_students_by_name("Name")).must_include @student
    end
  end
end

describe "negative tests" do
  it "must raise error for setting date of birth as other class than Date" do
    expect { Student.new("Surname", "Name", "2000-01-01") }.must_raise ArgumentError
  end
  it "must raise error for setting today date for birth date of person" do
    expect { Student.new("Surname", "Name", Date.today) }.must_raise ArgumentError
  end
end

