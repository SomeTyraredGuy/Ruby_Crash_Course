require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../app/student'

Minitest::Reporters.use! [
                           Minitest::Reporters::HtmlReporter.new(
                             reports_dir: 'mini_test/unit_reports',
                             report_filename: 'test_results.html',
                             # clean: true,
                             add_timestamp: true
                           )
                         ]

class MyTest < Minitest::Test

  def setup
    @student = Student.new("Surname", "Name", Date.new(2000,1,1))
  end

  def teardown
    Student.remove_student @student.surname, @student.name, @student.date_of_birth
    @student = nil
  end

  def test_date_of_birth_validation
    assert_raises ArgumentError do
      Student.validate_date_of_birth("String")
    end
    assert_raises ArgumentError do
      Student.validate_date_of_birth(Date.today)
    end
  end

  def test_calculate_age
    @student.date_of_birth = Date.new(Date.today.year, Date.today.month, Date.today.day - 1)
    assert_instance_of Integer, @student.calculate_age
    assert_equal(@student.calculate_age(), 0, "Age of person should be equal to 0")
  end

  def test_add_student
    assert_equal false, Student.add_student(@student)

    Student.remove_student @student.surname, @student.name, @student.date_of_birth
    assert Student.add_student @student    
    assert_equal @student, Student.find(@student.surname, @student.name, @student.date_of_birth)
  end

  def test_remove_student
    assert Student.remove_student @student.surname, @student.name, @student.date_of_birth
    assert_nil Student.find(@student.surname, @student.name, @student.date_of_birth)
    assert_equal false, Student.remove_student(@student.surname, @student.name, @student.date_of_birth)
  end

  def test_find
    student = Student.find(@student.surname, @student.name, @student.date_of_birth)
    assert_instance_of Student, student
    assert_same @student, student
  end
  
  def test_get_students_by_age
    assert_empty Student.get_students_by_age(Date.today)
    assert_includes Student.get_students_by_age(@student.calculate_age), @student
  end

  def test_get_students_by_name
    assert_empty Student.get_students_by_name("")
    assert_includes Student.get_students_by_name(@student.name), @student
  end

end