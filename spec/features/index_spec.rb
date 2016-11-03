require 'spec_helper'

describe 'index', type: :feature, js: true do
  before do
    visit '/'
  end

  it 'make sure of German and English paragraph' do
    expect(page).to have_content 'Webmontag Köln'
    click_on("Switch to English version")
    expect(page).to have_content 'Web Monday'
  end

end
