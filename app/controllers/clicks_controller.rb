class ClicksController < ApplicationController
  def show
    link = Link.find_by(shorten_code: params[:shorten_code])

    if link.present?
      link.increment_clicks!
      redirect_to link.url, allow_other_host: true
    else
      redirect_to root_path, alert: 'Incorrect URL'
    end
  end
end
