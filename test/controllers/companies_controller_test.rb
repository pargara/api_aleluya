# frozen_string_literal: true

require 'test_helper'
require_relative '../helpers/authorization_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @company = companies(:company_one)
    # @user = users(:user_one)
    # @user = {email: 'user1@example.com', password: 'password'}
    # sign_in (@user)
    # @auth_tokens = auth_headers(@user)
    # auth_tokens_for_user(@user)

    test_user = { email: 'user@test.com', password: 'testuser' }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test 'should get index' do
    # get companies_url, headers: @token, as: :json
    get companies_url, headers: @auth_tokens, as: :json
    assert_response :success
  end

  test 'should create company' do
    assert_difference('Company.count') do
      post companies_url,
        params: { company: { direction: @company.direction, mail: @company.mail, name: "Aleluya-", phone: @company.phone, user_id: @company.user_id } }, headers: @auth_tokens, as: :json

    end
    assert_response :created
  end

  test 'should show company' do
    get company_url(@company), headers: @auth_tokens, as: :json
    assert_response :success
  end

  test 'should update company' do
    patch company_url(@company),
          params: { company: { direction: @company.direction, mail: @company.mail, name: @company.name, phone: @company.phone, user_id: @company.user_id } }, headers: @auth_tokens, as: :json
    assert_response :success
  end

  test 'should destroy company' do
    assert_difference('Company.count', -1) do
      delete company_url(@company), headers: @auth_tokens, as: :json
    end

    assert_response :no_content
  end
end
