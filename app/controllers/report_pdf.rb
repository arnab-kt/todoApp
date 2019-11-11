require 'prawn'
class ReportPdf < Prawn::Document

  def initialize(todos)
    super(top_margin: 20)
    @todos = todos
    write_lines
  end

  def write_lines
    data = []
    @todos.each do |todo|
      data << [
        todo.description,
        todo.date,
        todo.done
      ]

      table(data)
    end
  end

end