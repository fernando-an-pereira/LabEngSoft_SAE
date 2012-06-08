require 'test_helper'

class ChamadaControllerTest < ActionController::TestCase
  test "should get enviarMensagem" do
    get :enviarMensagem
    assert_response :success
  end

end
