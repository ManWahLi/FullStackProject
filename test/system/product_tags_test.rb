require "application_system_test_case"

class ProductTagsTest < ApplicationSystemTestCase
  setup do
    @product_tag = product_tags(:one)
  end

  test "visiting the index" do
    visit product_tags_url
    assert_selector "h1", text: "Product tags"
  end

  test "should create product tag" do
    visit product_tags_url
    click_on "New product tag"

    fill_in "Product", with: @product_tag.product_id
    fill_in "Tag", with: @product_tag.tag_id
    click_on "Create Product tag"

    assert_text "Product tag was successfully created"
    click_on "Back"
  end

  test "should update Product tag" do
    visit product_tag_url(@product_tag)
    click_on "Edit this product tag", match: :first

    fill_in "Product", with: @product_tag.product_id
    fill_in "Tag", with: @product_tag.tag_id
    click_on "Update Product tag"

    assert_text "Product tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Product tag" do
    visit product_tag_url(@product_tag)
    click_on "Destroy this product tag", match: :first

    assert_text "Product tag was successfully destroyed"
  end
end
