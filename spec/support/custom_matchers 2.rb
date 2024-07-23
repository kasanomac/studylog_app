# spec/support/custom_matchers.rb

RSpec::Matchers.define :have_contents do |*contents|
    match do |page|
      contents.all? { |content| page.has_content?(content) }
    end
  
    failure_message do |page|
      missing_contents = contents.reject { |content| page.has_content?(content) }
      "expected page to have contents: #{missing_contents.join(', ')}"
    end
  
    failure_message_when_negated do |page|
      present_contents = contents.select { |content| page.has_content?(content) }
      "expected page not to have contents: #{present_contents.join(', ')}"
    end
end

# spec/support/custom_matchers.rb

RSpec::Matchers.define :have_links do |*links|
    match do |page|
      links.all? { |link| page.has_link?(link) }
    end
  
    failure_message do |page|
      missing_links = links.reject { |link| page.has_link?(link) }
      "expected page to have links: #{missing_links.join(', ')}"
    end
  
    failure_message_when_negated do |page|
      present_links = links.select { |link| page.has_link?(link) }
      "expected page not to have links: #{present_links.join(', ')}"
    end
end
  
  