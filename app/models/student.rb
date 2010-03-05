class Student < ActiveRecord::Base

  before_save :set_total_hours

  has_many :hours

  # validate
  # column : name, student_number, id_number
#  validates_presence_of :name, :student_number, :id_number 

  accepts_nested_attributes_for :hours, :reject_if => lambda { |a| a.values.all?(&:blank?) }, :allow_destroy => true

  named_scope :keyword, lambda { |keys| 

    elements = []
    entire_sql = keys.dup

    entire_sql.strip!
    entire_sql.squeeze!(' ')
    entire_sql.gsub!(/ +/, ' AND ')

    entire_sql.gsub!(/ +AND +\+ +AND +/, '+')
    entire_sql.gsub!(/ +\( +AND +/, '(')
    entire_sql.gsub!(/ +AND +\) +/, ')')
    entire_sql.gsub!('+', ' OR ')

    entire_sql.squeeze!(' ')

    entire_sql.dup.scan(/\w+/) do |key|
      unless key == "AND" || key == "OR"
        columns_for_search = 
          ["name", "student_number", "department", "id_number", "phone_number", "address",
            "post_office_account", "post_office_number", "memo",
            "email", "post_office_name", "home_tel", "work_tel"]
        holder = []
        columns_for_search.each do |column|
          holder << " #{column} like ? "
        end
        holder_str = holder.join(" OR ")
        elements << (["%#{key}%"] * columns_for_search.size)
        entire_sql.sub!(/\b#{key}\b/, "( #{holder_str} )")
      end
    end
    elements.flatten!

    {:conditions => [entire_sql, *elements] }
  }

=begin
  def total_hours
    total = 0
    self.hours.each do |hour|
      total += (hour.total_hours || 0)
    end
    total
  end
=end

  private 
  # callback
  def set_total_hours
    self.total_hours = 0
    self.hours.each do |hour|
      self.total_hours += (hour.total_hours || 0)
    end
  end

end
