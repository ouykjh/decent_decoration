require 'fixtures/fake_rails_application'
require 'rspec/rails'

describe ConferencesController, type: :controller do
  before do
    get '/conference/RuPy'
  end

  describe "inside a view" do
    it "should be a decorator" do
      controller.view_context.conference.should be_instance_of(ConferenceDecorator)
    end

    it "should have decorated conference" do
      controller.view_context.conference.decorated_object.should be_instance_of(Conference)
    end

    it "should be specified decorator" do
      controller.view_context.other_conference.should be_instance_of(CoolConferenceDecorator)
    end

    it "should cache decorator" do
      controller.view_context.conference.object_id.should == controller.view_context.conference.object_id
    end

    it "should cache decorated object" do
      controller.view_context.conference.decorated_object.object_id.should == controller.view_context.conference.decorated_object.object_id
    end
  end

  describe "inside a controller" do
    it "should be undecorated object" do
      controller.conference.should be_instance_of(Conference)
    end

    it "should not be specified decorator" do
      controller.other_conference.should be_instance_of(Conference)
    end
  end
end
