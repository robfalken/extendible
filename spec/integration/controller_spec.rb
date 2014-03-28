require 'spec_helper'

require 'rails'
require 'action_controller/railtie'
require 'rspec/rails'

module TestApp
  class Application < Rails::Application
    config.secret_token = '572c86f5ede338bd8aba8dae0fd3a326aabababc98d1e6ce34b9f5'
    config.secret_key_base = '572c86f5ede338bd8aba8dae0fd3a326aabababc98d1e6ce34b9f5'
    routes.draw do
      get 'show' => 'anonymous#show'
    end
  end

  class ApplicationController < ActionController::Base
    include Rails.application.routes.url_helpers
    serialization_scope :params
  end
end

def params
  @params = {}
end

describe Extendible do

  context 'foobar', type: :controller do
    controller(TestApp::ApplicationController)  do
      def show
        render json: MyObjectSerializer.new(MyObject.new).as_json
      end
    end

    before(:each) { @request = ActionController::TestRequest.new }

    describe 'GET #show' do
      it 'works' do
        get :show, {id: 1, extend: 'entitled_ref'}
        expect(response).to be_ok
      end
    end
  end

end
