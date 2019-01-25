module Manage
  class DuesController < ApplicationController
    def index
      @year = Date.current.strftime('%Y')
    end
  end
end
