require File.dirname(__FILE__) + '/test_helper'

Expectations do
  expect Post.to.be.permits?(:create, stub(:let_me_create? => true))
  expect Post.not.to.be.permits?(:create, stub(:let_me_create? => false))
end

