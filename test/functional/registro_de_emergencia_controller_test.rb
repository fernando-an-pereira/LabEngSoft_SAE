require 'test_helper'

class RegistroDeEmergenciaControllerTest < ActionController::TestCase
  setup do
    @registro_de_emergencium = registro_de_emergencia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registro_de_emergencia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registro_de_emergencium" do
    assert_difference('RegistroDeEmergencium.count') do
      post :create, registro_de_emergencium: { causas: @registro_de_emergencium.causas, data: @registro_de_emergencium.data, gravidade: @registro_de_emergencium.gravidade, localidadeEmergencia: @registro_de_emergencium.localidadeEmergencia }
    end

    assert_redirected_to registro_de_emergencium_path(assigns(:registro_de_emergencium))
  end

  test "should show registro_de_emergencium" do
    get :show, id: @registro_de_emergencium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registro_de_emergencium
    assert_response :success
  end

  test "should update registro_de_emergencium" do
    put :update, id: @registro_de_emergencium, registro_de_emergencium: { causas: @registro_de_emergencium.causas, data: @registro_de_emergencium.data, gravidade: @registro_de_emergencium.gravidade, localidadeEmergencia: @registro_de_emergencium.localidadeEmergencia }
    assert_redirected_to registro_de_emergencium_path(assigns(:registro_de_emergencium))
  end

  test "should destroy registro_de_emergencium" do
    assert_difference('RegistroDeEmergencium.count', -1) do
      delete :destroy, id: @registro_de_emergencium
    end

    assert_redirected_to registro_de_emergencia_path
  end
end
