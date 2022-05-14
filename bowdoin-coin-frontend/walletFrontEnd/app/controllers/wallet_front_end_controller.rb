class WalletFrontEndController < ApplicationController
  protect_from_forgery with: :null_session

  def index
  end


  def getUserBalance
    require 'socket'
    puts "---------- In Index ----------"
    user = params[:user]

    begin
      s = TCPSocket.new '139.140.211.20', 8101
      s.puts "userBalance--keys/" + user + ".der"
      s.flush
      @balance1 = s.gets
      s.close
    rescue
      respond_to do |format|
        format.html {redirect_to "/wallet_front_end/error"} 
      end
    else

      if Info.all == []  #this will be true only if the website is being used for the first time: nothing will be in database
        map = {"balance" => @balance1}
        newRow = Info.new(map)
        respond_to do |format|
          if newRow.save
            format.html {redirect_to wallet_front_end_url} 
          else
            format.html {redirect_to wallet_front_end_url} 
          end
        end

      else
        info = Info.all.first
        respond_to do |format|
          if info.update({"balance"=> @balance1})
            format.html {redirect_to "/wallet_front_end/balance"} 
          else
            format.html {redirect_to "/wallet_front_end/error"} 
          end
        end

      end
    end
    
  end

 

  def makeTransaction
    require 'socket'
    puts "---------- In Index ----------"
    sender = params[:sender]
    recipient = params[:recipient]
    amount = params[:amount]
    senderp = params[:senderp]

    @line = ""

    begin
      s = TCPSocket.new '139.140.211.20', 8101
      s.puts "makeTransaction--keys/" + sender + ".der--keys/" + senderp + ".der--keys/" + recipient + ".der--" + amount
      s.flush
      @line = s.gets 
      s.close
    rescue
      respond_to do |format|
        format.html {redirect_to "/wallet_front_end/error"} 
      end
    else
      puts @line
      if @line.strip.eql?("true")
        respond_to do |format|
          format.html {redirect_to "/wallet_front_end/success"} 
        end
      else
        respond_to do |format|
          format.html {redirect_to "/wallet_front_end/error"} 
       end
      end

    end
    
    
  end


  def handlePost
    if params[:commit] == "Make Transaction"
      makeTransaction
    elsif params[:commit] == "Get User Balance"
      getUserBalance
    elsif params[:commit] == "Go back"
      puts "go back"
      respond_to do |format|
        format.html {redirect_to wallet_front_end_url} 
      end
    end
  end

  def success
  end
  
  def error
  end

end
