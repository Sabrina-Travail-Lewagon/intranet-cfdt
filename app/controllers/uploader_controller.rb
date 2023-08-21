class UploaderController < ApplicationController
  def image
    image_data = params[:file]
    # Utilisez le SDK Cloudinary pour envoyer l'image à Cloudinary
    cloudinary_response = Cloudinary::Uploader.upload(image_data)
    # Renvoyez une réponse JSON avec l'URL de l'image envoyée à Cloudinary
    render json: { location: cloudinary_response["secure_url"] }, status: :created
  end
end
