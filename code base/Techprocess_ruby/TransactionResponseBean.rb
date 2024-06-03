require_relative 'RequestValidate'
require_relative 'AES'

class TransactionResponseBean
  protected
  @responsePayload
  @key
  @iv  
  @blockSize
  @mode
  
  public
  attr_accessor :responsePayload
  attr_accessor :key
  attr_accessor :iv  
  attr_accessor :blocksize
  attr_accessor :mode  
  
  def initialize
  
    	# setting initial value (optional)
    	@blockSize = 128
    	@mode = "cbc"
    	    	
  end
  	
  # This function decrypts the final response and returns it to the merchant.
  # * *Returns* :
  #   - +string+ -> the result decryptResponse
  
  def getResponsePayload
  
	begin
		_requestValidate = RequestValidate.new
		_responseParams = {}
		_responseParams[:pRes] = @responsePayload		
		_responseParams[:pEncKey] = @key
		_responseParams[:pEncIv] = @iv
		_errorResponse = _requestValidate.validateResponseParam(_responseParams)
		
		if _errorResponse
			return _errorResponse
		end

		_aes = AES.new(@responsePayload,@key,@blockSize,@mode,@iv)
		_decryptResponse = _aes.decrypt.gsub(/[\x00-\x1F\x7F]/, '').strip

		_hashValue = _decryptResponse.match(/hash=([^|]+)/)&.captures&.first
		_hashAlgo = _decryptResponse.match(/hashAlgo=([^|]+)/)&.captures&.first
		_randomSalt = _decryptResponse.match(/random_salt=([^|]+)/)&.captures&.first

		_decryptResponse.gsub!(/(hash|hashAlgo|random_salt)=[^|]+\|?/, '').strip
		_decryptResponse += "#{_randomSalt}"

		_generatedHash = OpenSSL::Digest.new(_hashAlgo).hexdigest(_decryptResponse)

		if _generatedHash == _hashValue
			return _decryptResponse
		else
			return "ERROR064"
		end
		
	rescue Exception => e  
  		puts "Exception In TransactionResponseBean :#{e.message}"
		return  
	end
	
	return "ERROR037"
	
  end
  
end