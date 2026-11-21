require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "root is about page" do
    get root_url
    assert_response :success
    assert_select "h1", "Про проєкт"
  end

  test "should get static pages" do
    [ about_url, quick_start_url, api_docs_url, faq_url ].each do |url|
      get url
      assert_response :success
    end
  end

  test "layout has header version and footer github button" do
    get root_url
    assert_select "header .badge", "v#{APP_VERSION}"
    assert_select "footer a", "Редагувати на GitHub"
  end
end
