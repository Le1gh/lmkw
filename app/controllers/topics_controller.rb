# frozen_string_literal: true

class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end
end
