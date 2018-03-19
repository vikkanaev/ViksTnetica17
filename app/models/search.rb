class Search < ApplicationRecord
  SEARCH_DOMAINS = %w[Questions Answers Comments Users].freeze

  def self.search_result(search_string, search_area)
    string_with_escape = ThinkingSphinx::Query.escape(search_string)
    if SEARCH_DOMAINS.include?(search_area)
      search_area.singularize.classify.constantize.search string_with_escape, star: true
    else
      ThinkingSphinx.search string_with_escape, star: true
    end
  end
end
