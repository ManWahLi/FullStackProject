require "test_helper"

class ProductTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_tag = product_tags(:one)
  end

  test "should get index" do
    get product_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_product_tag_url
    assert_response :success
  end

  test "should create product_tag" do
    assert_difference("ProductTag.count") do
      post product_tags_url, params: { product_tag: { product_id: @product_tag.product_id, tag_id: @product_tag.tag_id } }
    end

    assert_redirected_to product_tag_url(ProductTag.last)
  end

  test "should show product_tag" do
    get product_tag_url(@product_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_tag_url(@product_tag)
    assert_response :success
  end

  test "should update product_tag" do
    patch product_tag_url(@product_tag), params: { product_tag: { product_id: @product_tag.product_id, tag_id: @product_tag.tag_id } }
    assert_redirected_to product_tag_url(@product_tag)
  end

  test "should destroy product_tag" do
    assert_difference("ProductTag.count", -1) do
      delete product_tag_url(@product_tag)
    end

    assert_redirected_to product_tags_url
  end
end
