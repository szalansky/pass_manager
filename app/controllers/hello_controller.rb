class HelloController < ApplicationController
  skip_before_filter :authenticate_or_examine!, :only => [:index]
  def index
  end

  def say_hello
  end
end
