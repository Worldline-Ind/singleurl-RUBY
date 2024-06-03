module Paynimo
	class AES
 
  protected
  @key
  @cipher
  @data
  @mode
  @IV  
  
  def initialize(data = nil, key = nil, blocksize = nil, mode = nil, iv)
  
  	@key = key
  	@cipher = blocksize
  	@data = data
  	@mode = mode
  	@IV = iv 
  	 	
  end  
  
  public
  #This function checks whether the mandatory values are set and returns true. Returns false otherwise.
  # * *Returns* :
  #   - +boolean+ -> the result 
  
  def validateParams  
  
  	if !@data.nil? && !@key.nil? && !@cipher.nil?
		return true
  	else
		return false  	
  	end
  	
  end
  
  # This function encrypts the data according to the key, mode and iv provided
  # and convert it into base64 encoded format
  # * *Returns* :
  #   - +string+ -> the result 
  # * *throws* :
  #   - +exception+ 
  
  def encrypt 
  
  	if validateParams
  		if @IV.empty?
			_iv = OpenSSL::Cipher::Cipher.new("aes-#{ @cipher }-#{ @mode }").random_iv
		else
			_iv= @IV
		end
		Encryptor.default_options.merge!(:algorithm => "aes-#{ @cipher }-#{ @mode }", :key => @key, :iv => _iv)		
		_cyper_text = Encryptor.encrypt(@data)
		_rt = Base64.strict_encode64(_cyper_text)
		return _rt	
	else
		raise "Provide valid details to get transaction token"  		
  	end
  	
  end
   
  # This function encrypts the data according to the key, mode and iv provided
  # and convert it into base64 encoded format
  # * *Returns* :
  #   - +string+ -> the result
   
  def decrypt
  	if @IV.empty?
		_iv = OpenSSL::Cipher::Cipher.new("aes-#{ @cipher }-#{ @mode }").random_iv
	else
		_iv= @IV
	end
	
	Encryptor.default_options.merge!(:algorithm => "aes-#{ @cipher }-#{ @mode }", :key => @key, :iv => _iv)		
	_base64 = Base64.decode64(@data)
	_rt = Encryptor.decrypt(Base64.decode64(@data))
	return _rt
		
  end
  
  #This function encrypts the data according to the key, mode and iv provided
  # and convert it into hex encoded format
  # * *Returns* :
  #   - +string+ -> the result 
  # * *throws* :
  #   - +exception+ 
  
  def encryptHex
  
  	if @IV.empty?
		_iv = OpenSSL::Cipher::Cipher.new("aes-#{ @cipher }-#{ @mode }").random_iv
	else
		_iv= @IV
	end
	
	Encryptor.default_options.merge!(:algorithm => "aes-#{ @cipher }-#{ @mode }", :key => @key, :iv => _iv)
	_cyper_text = Encryptor.encrypt(@data)
	_rt = _cyper_text.unpack("H*")[0]
	
	return _rt
	
  end
  
  # This function decrypts the data according to the key, mode and iv provided
  # and convert it into hex encoded format
  # * *Returns* :
  #   - +string+ -> the result 
  # * *throws* :
  #   - +exception+
   
  def decryptHex
  
  	if @IV.empty?
		_iv = OpenSSL::Cipher::Cipher.new("aes-#{ @cipher }-#{ @mode }").random_iv
	else
		_iv= @IV
	end
	Encryptor.default_options.merge!(:algorithm => "aes-#{ @cipher }-#{ @mode }", :key => @key, :iv => _iv)
	_ret = ""
	(0...@data.size()/2).each{|index| _ret += [@data[index*2, 2]].pack("H2")}		
	_rt = Encryptor.decrypt(_ret)
		
	return _rt
	
  end
    
	end
end