# encoding: utf-8

require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist

describe "Form filling", :type => :feature do
    before :each do
        visit root_path
    end
    it "With valid data, to submit the form" do
       	click_on()
        fill_in('sports_map[radius]', :with => '5')
        check('sports_map[air-quality]')
        check('sports_map[bike-paths]')
        uncheck('sports_map[bike-paths]')
        check('sports_map[ultraviolet]')
        check('sports_map[humidity]')
        check('sports_map[temperature]')
        check('sports_map[green-areas]')
        uncheck('sports_map[green-areas]')
        click_on('Submit')
        
    end
end
