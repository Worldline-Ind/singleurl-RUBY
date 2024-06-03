module Paynimo
	class TransactionRequestBean
	@@mkd
	@@currDate
	private
	@@rqst_kit_vrsn = 1
	@tilda	
	@separator
	@requestType = ""
	@merchantCode = ""
	@merchantTxnRefNumber = ""
	@ITC = ""
	@amount = ""
	@accountNo = ""
	@currencyCode = ""
	@uniqueCustomerId = ""
	@returnURL = ""
	@s2SReturnURL = ""
	@TPSLTxnID = ""
	@shoppingCartDetails = ""
	@txnDate = ""
	@email = ""
	@mobileNumber = ""
	@socialMediaIdentifier = ""
	@bankCode = ""
	@customerName = ""
	@reqst = nil
	@webServiceLocator
	@hashingAlgorithm
	@MMID = ""
	@OTP = ""
	@key
	@iv
	@blockSize
	@mode
	@logPath = ""
	@custId = ""
	@cardId = ""
	@cardNo = ""
	@cardName = ""
	@cardCVV = ""
	@cardExpMM = ""
	@cardExpYY = ""
	@timeOut
	
	public
	
	def self.rqst_kit_vrsn
		@@rqst_kit_vrsn ||= nil
	end
    def self.rqst_kit_vrsn=(value)
    	@@rqst_kit_vrsn = value
    end
	
	def self.mkd
		@@mkd ||= nil
	end
    def self.mkd=(value)
    	@@mkd = value
    end
    
    def self.currDate
		@@currDate ||= nil
	end
    def self.currDate=(value)
    	@@currDate = value
    end
    
	attr_accessor :tilda
	attr_accessor :separator
	attr_accessor :requestType
	attr_accessor :merchantCode
	attr_accessor :merchantTxnRefNumber
	attr_accessor :ITC
	attr_accessor :amount
	attr_accessor :accountNo
	attr_accessor :currencyCode
	attr_accessor :uniqueCustomerId
	attr_accessor :returnURL
	attr_accessor :s2SReturnURL
	attr_accessor :TPSLTxnID
	attr_accessor :shoppingCartDetails
	attr_accessor :txnDate
	attr_accessor :email
	attr_accessor :mobileNumber
	attr_accessor :socialMediaIdentifier
	attr_accessor :bankCode
	attr_accessor :customerName
	attr_accessor :reqst
	attr_accessor :webServiceLocator
	attr_accessor :hashingAlgorithm
	attr_accessor :MMID
	attr_accessor :OTP
	attr_accessor :key
	attr_accessor :iv
	attr_accessor :blockSize
	attr_accessor :mode
	attr_accessor :logPath
	attr_accessor :custId
	attr_accessor :cardId
	attr_accessor :cardNo
	attr_accessor :cardName
	attr_accessor :cardCVV
	attr_accessor :cardExpMM
	attr_accessor :cardExpYY
	attr_accessor :timeOut	
	
	
	def initialize
	
    	# setting initial value (optional)
    	@blockSize = 128
    	@mode = "cbc"
    	@timeOut = 30
    	@webServiceLocator = "NA"
    	@tilda = "~"		
		@separator = "|"
		
  	end
  
	# This function encrypts request params details   
    # * *Returns* :
    #   - +string+ -> the result 
    
	def getEncryptedData
	
		begin
			_clientMetaData = ""
			
			_requestValidate = RequestValidate.new
			
			if !_requestValidate.isBlankOrNull(@ITC)
				_clientMetaData += "{itc:#{@ITC}}"
			end					 
			if !_requestValidate.isBlankOrNull(@email)
				_clientMetaData += "{email:#{@email}}"
			end			
			if !_requestValidate.isBlankOrNull(@mobileNumber)
				_clientMetaData += "{mob:#{@mobileNumber}}"
			end  
			if !_requestValidate.isBlankOrNull(@uniqueCustomerId)
				_clientMetaData += "{custid:#{@uniqueCustomerId}}"
			end
			if !_requestValidate.isBlankOrNull(@customerName)
				_clientMetaData += "{custname:#{@customerName}}"
			end			
			_strReqst = ""
			if !_requestValidate.isBlankOrNull(@requestType)
				_strReqst += "rqst_type=#{@requestType}"
			end
			_strReqst += "|rqst_kit_vrsn=1.0.#{@@rqst_kit_vrsn}"
			if !_requestValidate.isBlankOrNull(@merchantCode)
				_strReqst += "|tpsl_clnt_cd=#{@merchantCode}"
			end
			if !_requestValidate.isBlankOrNull(@accountNo)
				_strReqst += "|accountNo=#{@accountNo}"
			end
			if !_requestValidate.isBlankOrNull(@merchantTxnRefNumber)
				_strReqst += "|clnt_txn_ref=#{@merchantTxnRefNumber}"
			end
			if !_requestValidate.isBlankOrNull(_clientMetaData)
				_strReqst += "|clnt_rqst_meta=#{String(_clientMetaData)}"
			end
			if !_requestValidate.isBlankOrNull(@amount)
				_strReqst += "|rqst_amnt=#{@amount}"
			end
			if !_requestValidate.isBlankOrNull(@currencyCode)
				_strReqst += "|rqst_crncy=#{@currencyCode}"
			end
			if !_requestValidate.isBlankOrNull(@returnURL)
				_strReqst += "|rtrn_url=#{@returnURL}"
			end
			if !_requestValidate.isBlankOrNull(@s2SReturnURL)
				_strReqst += "|s2s_url=#{@s2SReturnURL}"
			end
			if !_requestValidate.isBlankOrNull(@shoppingCartDetails)
				_strReqst += "|rqst_rqst_dtls=#{@shoppingCartDetails}"
			end
			if !_requestValidate.isBlankOrNull(@txnDate)
				_strReqst += "|clnt_dt_tm=#{@txnDate}"
			end
			if !_requestValidate.isBlankOrNull(@bankCode)
				_strReqst += "|tpsl_bank_cd=#{@bankCode}"
			end
			if !_requestValidate.isBlankOrNull(@TPSLTxnID)
				_strReqst += "|tpsl_txn_id=#{@TPSLTxnID}"
			end
			if !_requestValidate.isBlankOrNull(@custId)
				_strReqst += "|cust_id=#{@custId}"
			end
			if !_requestValidate.isBlankOrNull(@cardId)
				_strReqst += "|card_id=#{@cardId}"
			end
			if !_requestValidate.isBlankOrNull(@mobileNumber)
				_strReqst += "|mob=#{@mobileNumber}"
			end
			if !_requestValidate.isBlankOrNull(@hashingAlgorithm)
				_strReqst += "|mob=#{@hashingAlgorithm}"
			else
				@hashingAlgorithm="SHA-512"
			end
			
			if @requestType=="TWC" || @requestType=="TRC" || @requestType=="TIC"
				_cardInfoBuff = ""
				_cardInfoBuff += "card_Hname=#{@cardName}"
				_cardInfoBuff += "|card_no=#{@cardNo}"
				_cardInfoBuff += "|card_Cvv=#{@cardCVV}"
				_cardInfoBuff += "|exp_mm=#{@cardExpMM}"
				_cardInfoBuff += "|exp_yy=#{@cardExpYY}"
				
				_aes = AES.new(_cardInfoBuff,@key,@blockSize,@mode,@iv)
				_cardInfoStr = _aes.encryptHex
				
				_aes = AES.new(_cardInfoStr,@key,@blockSize,@mode,@iv)
				_cardInfo = _aes.encryptHex
				
				_strReqst += "|card_details=#{_cardInfo}"
			elsif @requestType=="TCC"
				_cardInfoBuff = ""
				_cardInfoBuff += "|card_Cvv=#{@cardCVV}"
				
				_aes = AES.new(_cardInfoBuff,@key,@blockSize,@mode,@iv)
				_cardInfoStr = _aes.encryptHex
				
				_aes = AES.new(_cardInfoStr,@key,@blockSize,@mode,@iv)
				_cardInfo = _aes.encryptHex
				
				_strReqst += "|card_details=#{_cardInfo}"
			elsif @requestType=="TWI"
				_impsInfoBuff = ""
				_impsInfoBuff +="mmid=#{@MMID}"
				_impsInfoBuff +="|mob_no=#{@mobileNumber}"
				_impsInfoBuff +="|otp=#{@OTP}"
				
				_aes = AES.new(_impsInfoBuff,@key,@blockSize,@mode,@iv)
				_impsInfoStr = _aes.encryptHex
				
				_aes = AES.new(_impsInfoStr,@key,@blockSize,@mode,@iv)
				_impsInfo = _aes.encryptHex
				
				_strReqst += "|imps_details=#{_impsInfo}"
			elsif @requestType=="TIO"
				_strReqst +="|otp=#{@OTP}"
			end
			
			_salt = OpenSSL::Random.random_bytes(16).unpack('H*').first

			_withSalt = "#{_strReqst}|#{_salt}"
			_strReqst +="|hash=#{OpenSSL::Digest.new(@hashingAlgorithm).hexdigest(_withSalt)}|hashAlgo=#{@hashingAlgorithm}|random_salt=#{_salt}"
			_aes = AES.new(_strReqst,@key,@blockSize,@mode,@iv)		
			_encryptedData = _aes.encrypt
			return _encryptedData;
			
		rescue Exception => e  
			puts e.message
			return
		end
		
		return _encryptedData 
		
	end

	# This function returns transaction token url   
    # * *Returns* :
    #   - +string+ -> the result 
    
	def getTransactionToken
	
		status = Timeout::timeout(@timeOut.to_i) {
		
			if !@webServiceLocator.nil? && @webServiceLocator!="" && @webServiceLocator!="NA"
				_requestValidate = RequestValidate.new
				_params = {}
				_params[:pReqType] = @requestType
				_params[:pMerCode] = @merchantCode
				_params[:pEncKey] = @key
				_params[:pEncIv] = @iv
				
				_errorResponse = _requestValidate.validateRequestParam(_params)
				
				if _errorResponse
					return _errorResponse
				end
				
				_encryptedData = getEncryptedData
				if !_encryptedData
					return 
				end
				begin				
					_postData = "#{_encryptedData}|#{@merchantCode}~"									
					# _client = Savon.client(wsdl: @webServiceLocator)
					_client = Savon.client do |globals|
					globals.wsdl @webServiceLocator
					globals.ssl_verify_mode :none
					globals.follow_redirects true
					end
					_response = _client.call(:get_transaction_token, message:{'msg'=>_postData})
				rescue Exception => e  
		  			puts "Error while getting transaction token :#{e.message}"
		  			return  e.message
				end	
							
				return !_response.body[:get_transaction_token_response][:get_transaction_token_return].blank? ? _response.body[:get_transaction_token_response][:get_transaction_token_return] : nil
				
			end
		}
	end
	end
end