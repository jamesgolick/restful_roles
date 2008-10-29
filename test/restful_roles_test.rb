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
end

