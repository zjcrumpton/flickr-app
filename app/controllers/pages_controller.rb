class PagesController < ApplicationController
  before_action :init_flickr

  def show
    render template: "pages/#{params[:page]}"
  end

  def photos
    grab_photos
    # render template: "pages/photos"
    render :photos
  end

  
  private

  def init_flickr
    flickr = FlickRaw::Flickr.new
  end

  def grab_photos
    # @user_id = '189980796@N03'
    @user_id = params[:user_id]
    @photos = []
    @list = flickr.people.getPublicPhotos(:user_id => @user_id)

    @list.each do |p|
      id = p.id
      secret = p.secret
      info = flickr.photos.getInfo :photo_id => id, :secret => secret
      @photos << FlickRaw.url_o(info)
    end
    puts @photos
  end
end
