require 'spec_helper'

describe 'index', :type => :feature do
  before do
    visit '/'
  end

  it 'has a paragraph in there too' do
    expect(page).to have_content 'Web Monday is an informal'
  end
end
