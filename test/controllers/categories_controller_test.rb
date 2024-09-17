require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:jeanne)
  end

  test "#index" do
    get categories_path
    assert_response :success
  end

  test "#show" do
    get category_path categories(:home)
    assert_response :success
  end

  test "#new" do
    get new_category_path
    assert_response :success
  end

  test "#create" do
    assert_difference -> { users(:jeanne).categories.count }, 1 do
      post categories_path, params: { category: { name: "New category" } }
    end

    assert_redirected_to categories_path
  end

  test "#edit" do
    get edit_category_path categories(:home)
    assert_response :success
  end

  test "#update" do
    assert_changes -> { categories(:home).reload.name }, to: "Updated name" do
      patch category_path categories(:home), params: { category: { name: "Updated name" } }
    end

    assert_redirected_to categories_path
  end

  test "#destroy" do
    assert_difference -> { users(:jeanne).categories.count }, -1 do
      delete category_path(categories(:home))
    end

    assert_redirected_to categories_path
  end
end
