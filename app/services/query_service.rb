class QueryService
  def self.query(tasks:, search_input:)
    tasks.select { |task| task.title =~ Regexp.new(search_input) }
  end
end
