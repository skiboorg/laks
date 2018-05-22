class ClientController < ApplicationController

  def login
    client = Client.find_by(client_email: params[:login][:client_email].downcase)
    if client             ##check client exists
      if client.client_activated ##check client activated
        if client.client_password == params[:login][:client_password]##check client password

          # if client.lastlogin != Date.today
          # client.lastlogin=Date.today
          #  client.wallet += 30
          # client.save
          # end


          session[:active] = true
          session[:client_email] = client.client_email
          session[:client_id] = client.id
          session[:client_vip] = client.client_vip
          session[:admin] = client.client_admin


          respond_to do |format|
            format.js {render inline: " window.location.reload()" }

          end

        else          ##wrong password
          respond_to do |format|
            @res = 'Неверный пaроль'
            format.js
          end           ##end respond
        end             ##end check client password

      else          ##client not activated
        respond_to do |format|
          @res = 'Аккаунт не активирован'
          format.js
        end           ##end respond
      end               ##end check client activated

    else              ##client not exists
      respond_to do |format|
        @res = 'Аккаунт не зарегистрирован'
        format.js
      end           ##end respond
    end                 ##end check client exists


  end

  def registration
    nn1=params.permit(:n1).to_h[:n1].to_i
    nn2=params.permit(:n2).to_h[:n2].to_i
    nn3=params.permit(:n3).to_h[:n3].to_i
    nn4=nn1+nn2
    if  nn3 == nn4    ##check captcha

      @client=Client.new(client_data)

      if @client.valid? ##check client
        @client.client_password = [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
        @client.client_name = params[:registration][:client_name]
        @client.client_family = params[:registration][:client_family]
        @client.client_phone = params[:registration][:client_phone]
        @client.save

        MailerMailer.activation(@client).deliver_later

        respond_to do |format|
          @res='Письмо с инструкцией по активации отправлено (возможно оно попадет в спам)'
          @status = 'ok'
          format.js
        end           ##end respond

      else            ##client create error

        respond_to do |format|

          @res=@client.errors[:client_email][0].to_s

          format.js
        end           ##end respond

      end             ##end check user




    else             ## wrong answer

      respond_to do |format|
        @res='Неверный ответ'
        format.js
      end           ##end respond


    end               ##end check captcha

  end

  def logout
    session[:active] = false
    reset_session
    redirect_to '/'
  end

  def activate
    u=Client.find(params[:id])
    if u.client_activated == false
      u.update_column(:client_activated, true)

      flash[:activatesuccess] = 'Аккаунт активирован.'

      session[:active] = true
      session[:client_email] = u.client_email
      session[:client_id] = u.id

      redirect_to root_path and return
    else
      flash[:activateerror] = 'Аккаунт уже активирован.'
      redirect_to root_path and return
    end
  end

  private
  def client_data
    params.require(:registration).permit(:client_email)
  end
end
