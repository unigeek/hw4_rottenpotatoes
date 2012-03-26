# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert e1 < e2, "Items sorted incorrectly"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
end

When /I add a new movie/ do |movie|
  fills_in 'movie_title', :with => movie[title]
  selects 'movie_rating', :from => movie[rating]
  selects 'movie_release_date_1i', :from => movie[release_date].to_date.year
  selects 'movie_release_date_2i', :from => movie[release_date].to_date.month
  selects 'movie_release_date_3i', :from => movie[release_date].to_date.day
  clicks_button 'commit'
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  m = Movie.find_by_title(arg1)
  m.director.should == arg2
  #pending # express the regexp above with the code you wish you had
end

