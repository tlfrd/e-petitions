When /^I search for "([^"]*)" petitions with "([^"]*)"$/ do |state, term|
  visit search_path(:state => state, :q => term)
end

When /^I search for "([^"]*)" petitions with "([^"]*)" ordered by "([^"]*)"$/ do |state, term, order_field|
  order_array = order_field.split(' ')
  visit search_path(:state => state, :q => term, :sort => order_array[0], :order => order_array[1])
end

When /^I search for "([^"]*)"$/ do |query|
  visit home_path
  fill_in :search, :with => query
  click_link_or_button "Search"
end

When /^sunspot is re\-indexed$/ do
  if Petition.respond_to?(:reindex)
    Petition.reindex
  end
end

Then /^I should not be able to search via free text$/ do
  expect(page).to have_no_css("form[action=search]")
end

Then /^I should see an? "([^"]*)" petition count of (\d+)$/ do |state, count|
  expect(page).to have_css(%{#other-search-lists a:contains("#{state.capitalize}")}, :text => count.to_s)
end
