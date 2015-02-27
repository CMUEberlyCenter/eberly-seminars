module SearchesHelper

  def format_autocomplete_results( options={} )
      options[:search_results].map do |r|
      { label: "#{r[:primary]}",
        value: "#{r[:data]}"
      }
    end
  end

end
