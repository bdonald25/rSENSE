require 'test_helper'
require_relative 'base_integration_test'

class SeachDataSetsTest < IntegrationTest
  self.use_transactional_fixtures = false

  setup do
    @project = projects(:one)
  end

  test 'search data sets' do
    visit project_path(@project)

    fill_in 'search', with: 'MyString'
    click_on 'Search'

    assert page.has_content?('MyString'),
      'Search does not find data set'

    assert page.has_no_content?('Sample Title'),
      'Search finds non-matching data set.'
  end

  test 'search data sets starting with number' do
    visit project_path(@project)

    fill_in 'search', with: '5'
    click_on 'Search'

    assert page.has_content?('5 apples'),
      'Search does not find data set'

    assert page.has_no_content?('Sample Title'),
      'Search finds non-matching data set.'
  end

  test 'search data sets no matches' do
    visit project_path(@project)

    fill_in 'search', with: 'no dataset with this name'
    click_on 'Search'

    assert page.has_content?('No Matching Data Sets.'),
      'Found data sets when it should not have'

    assert page.has_no_content?('Sample Title'),
      'Search finds data set when it should not.'
  end
end
