require 'spec_helper'

describe 'index', :type => :feature do
  before do
    visit '/'
  end

  it 'has a paragraph in there too' do
    expect(page).to have_content 'Web Monday is an informal'
  end

  it 'will click on js anchor' do
    click_on("Zur Deutschen Version")
    expect(page).to have_content 'Webmontag Köln'
  end


end
