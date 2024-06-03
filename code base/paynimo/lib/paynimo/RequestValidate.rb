module Paynimo
	class RequestValidate

	BLANK_REQUEST_TYPE = 'ERROR008'
	INVALID_REQUEST_TYPE = 'ERROR002'
	BLANK_MER_CODE = 'ERROR027'
	INVALID_KEY = 'ERROR067'
	INVALID_IV = 'ERROR068'
	BLANK_PG_RESPONSE = 'ERROR069'
	
	protected
	@@requestTypes =  Array['T','S','O','R','TIC','TIO','TWC','TRC','TCC','TWI']
		
		
	public 
		
	# This function validates the mandatory fields in the request.
	#
	# * *Args*    :
	#   - +requestParams+ -> the request parameter  
	# * *Returns* :
	#   - +errorArray+ -> the error code  
	def validateRequestParam(requestParams = {})
	
		if requestParams[:pReqType].blank? || isBlankOrNull(requestParams[:pReqType])
			return BLANK_REQUEST_TYPE
		elsif !(@@requestTypes.include? requestParams[:pReqType])
			return INVALID_REQUEST_TYPE  	
		end
		
		if requestParams[:pMerCode].blank? || isBlankOrNull(requestParams[:pMerCode])
			return BLANK_MER_CODE
		end
		
		if requestParams[:pEncKey].blank? || isBlankOrNull(requestParams[:pEncKey]) 
			return INVALID_KEY
		end
		
		if requestParams[:pEncIv].blank? || isBlankOrNull(requestParams[:pEncIv]) || requestParams[:pEncIv].length < 16
			return INVALID_IV
		end 
		
		return false 	
		
	end
	
	# This function validates the mandatory fields in the response..
	#
	# * *Args*    :
	#   - +responseParams+ -> the response parameter  
	# * *Returns* :
	#   - +errorArray+ -> the error code
	
	def validateResponseParam(responseParams = {})
	
		if responseParams[:pRes].blank? || isBlankOrNull(responseParams[:pRes])
			return BLANK_PG_RESPONSE
		end
		
		if responseParams[:pEncKey].blank? || isBlankOrNull(responseParams[:pEncKey]) 
			return INVALID_KEY
		end
		
		if responseParams[:pEncIv].blank? || isBlankOrNull(responseParams[:pEncIv]) || responseParams[:pEncIv].length < 16
			return INVALID_IV
		end
		
	end
	
	#This function checks if a value is blank, null or 'NA' and returns true, else returns false.
	#
	# * *Args*    :
	#   - +param+ -> the parameter 
	# * *Returns* :
	#   - +boolean+ -> the result
	
	def isBlankOrNull(param = null)
	
		if param.nil? || param==="NA" || param.empty?
		   return true
		else
		   return false
		end
		
	end
	
	end
end