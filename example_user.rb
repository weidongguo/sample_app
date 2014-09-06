class User
#   attr_accessor :name, :email  # generates attr_reader and attr_writer 
#   attr_reader(:name, :email)  # generates name() and email()  
#   attr_writer(:name, :email)  # generates name=() and email=()

  def name
    return @name
  end
  # reader for intance variable @name, can be skipped by using attr_reader()

  def name=(str)
    @name = str
  end
  # writer for instance variable @name, can be skipped by using attr_writer()


  def email
    @email
  end
  #reader for instance variable @email

  def email=(str)
    @email = str
  end
  #writer for instance var @email

  def initialize(attributes={})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end
