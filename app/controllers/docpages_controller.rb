class DocpagesController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "About", :about_path
  add_breadcrumb "Support", :support_path

  def home
  end

  def about
  end

  def support
  end
end
