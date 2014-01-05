module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, :sort => column, :direction => direction
  end

  def school_link(name)
    school = School.find_by_name(name)
    link_to name, school
  end
end
