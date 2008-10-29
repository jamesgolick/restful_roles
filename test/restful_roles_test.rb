require File.dirname(__FILE__) + '/test_helper'

Expectations do
  expect Post.to.be.permits?(:create, stub(:let_me_create? => true))
  expect Post.not.to.be.permits?(:create, stub(:let_me_create? => false))

  expect Post.new.to.be.permits?(:update, stub_everything) do |post|
    post.stubs(:likes?).returns(true)
  end

  expect Post.new.not.to.be.permits?(:update, stub_everything) do |post|
    post.stubs(:likes?).returns(false)
  end

  expect MockController.to.receive(:before_filter).with(:check_permissions, :only => :create) do
    MockController.send(:checks_permissions, :only => :create)
  end

  person = stub(:let_me_create? => true)
  expect Post.to.receive(:permits?).with(:create, person).returns(true) do
    controller = MockController.new
    controller.stubs(:current_user).returns(person)
    controller.stubs(:model).returns(Post)
    controller.stubs(:params).returns({:action => 'create'})
    controller.send(:check_permissions)
  end

  expect Post.to.receive(:permits?).with(:create, person).returns(true) do
    MockController.stubs(:before_filter)
    MockController.send(:checks_permissions, :trustee => :current_something_else)

    controller = MockController.new
    controller.stubs(:current_something_else).returns(person)
    controller.stubs(:model).returns(Post)
    controller.stubs(:params).returns({:action => 'create'})
    controller.send(:check_permissions)
  end

  expect MockController.any_instance.to.receive(:access_denied) do
    MockController.stubs(:before_filter)
    MockController.send(:checks_permissions, :trustee => :current_something_else)

    controller = MockController.new
    controller.stubs(:current_something_else).returns(person)
    controller.stubs(:model).returns(Post)
    controller.stubs(:params).returns({:action => 'create'})

    Post.stubs(:permits?).returns(false)
    controller.send(:check_permissions)
  end
end

