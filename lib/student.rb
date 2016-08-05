require 'pry'

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def self.create_table
    DB[:conn].execute("CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", self.name, self.grade)
    results = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1;")
    #binding.pry
    @id = results[0][0]
  end

  def self.create(arguments)
    student = Student.new(arguments[:name], arguments[:grade])
    student.save
    student
  end

end
# Your Student instances should initialize with a name, grade and an optional id. The default value of the id argument should be set to nil. This is because when we create new Student instances, we will not assign them an id. That is the responsibility of the database and we will learn more about that later.
# Student attributes should have an attr_accessor for name and grade but only an attr_reader for id. The only place id can be set equal to something is inside the initialize method, via: @id = some_id
