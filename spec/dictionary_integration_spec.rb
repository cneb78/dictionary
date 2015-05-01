require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the word path', {:type => :feature}) do
  it('processes user input to display a unique success page') do
    visit('/')
    click_link('Add word')
    fill_in('word', :with => 'run')
    click_button('Submit')
    expect(page).to have_content('You have successfully added the word run!')
  end

  it('processes user input to add word for display on dictionary page') do
    visit('/words/new')
    fill_in('word', :with => 'run')
    click_button('Submit')
    click_link('Go back to the Dictionary')
    expect(page).to have_content('run')
  end
end

describe('the definition path', {:type => :feature}) do
  it('processes user input for new definition and displays it on the word page') do
    visit('/words/new')
    fill_in('word', :with => 'run')
    click_button('Submit')
    click_link('Go back to the Dictionary')
    click_link('run')
    click_link('Add definition')
    fill_in('part_of_speech', :with => 'verb')
    fill_in('meaning', :with => 'move at a speed faster than a walk')
    click_button('Submit')
    expect(page).to have_content('verb: move at a speed faster than a walk')
  end
end
