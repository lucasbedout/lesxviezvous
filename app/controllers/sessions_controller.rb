class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Connexion reussie"
    else
      flash.now.alert = "Votre email ou votre mot de passe est invalide"
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end


end


