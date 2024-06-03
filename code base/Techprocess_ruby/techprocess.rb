require 'sinatra'
require 'date'
require_relative 'TransactionRequestBean'
require_relative 'TransactionResponseBean'
set :port, 7080
enable :sessions

use Rack::Session::Cookie, :key => 'rack.session',
:path => '/',
:secret => 'paynimo'

get '/' do 
  
  @txn_id = "TXN00#{rand(1..10000)}"
  @strCurDate = (Date.today).strftime("%d-%m-%Y")
  @strNo = rand(1..1000000)
  @returnUrl = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"   
  erb :techprocess_form
  
end

post '/' do

  if !params[:submit].blank?
  	_val = params
  	session[:iv] = _val[:iv]
  	session[:key] = _val[:key]
  	_transactionRequestBean = TransactionRequestBean.new
  	
  	_transactionRequestBean.merchantCode = _val[:mrctCode]
  	_transactionRequestBean.accountNo = _val[:tpvAccntNo]
  	_transactionRequestBean.ITC = _val[:itc]
  	_transactionRequestBean.mobileNumber = _val[:mobNo]
  	_transactionRequestBean.customerName = _val[:custname]
  	_transactionRequestBean.requestType = _val[:reqType]
  	_transactionRequestBean.merchantTxnRefNumber = _val[:mrctTxtID]
  	_transactionRequestBean.amount = _val[:amount]
  	_transactionRequestBean.currencyCode = _val[:currencyType]
  	_transactionRequestBean.returnURL = _val[:returnURL]
  	_transactionRequestBean.s2SReturnURL = _val[:s2SReturnURL]
  	_transactionRequestBean.shoppingCartDetails = _val[:reqDetail]
  	_transactionRequestBean.txnDate = _val[:txnDate]
  	_transactionRequestBean.bankCode = _val[:bankCode]
  	_transactionRequestBean.TPSLTxnID = _val[:tpsl_txn_id]
  	_transactionRequestBean.custId = _val[:custID]
  	_transactionRequestBean.cardId = _val[:cardID]
  	_transactionRequestBean.key = _val[:key]
  	_transactionRequestBean.iv = _val[:iv]
  	_transactionRequestBean.webServiceLocator = _val[:locatorURL]
  	_transactionRequestBean.hashingAlgorithm = _val[:hashAlgo]
  	_transactionRequestBean.MMID = _val[:mmid]
  	_transactionRequestBean.OTP = _val[:otp]
  	_transactionRequestBean.cardName = _val[:cardName]
  	_transactionRequestBean.cardNo = _val[:cardNo]
  	_transactionRequestBean.cardCVV = _val[:cardCVV]
  	_transactionRequestBean.cardExpMM = _val[:cardExpMM]
  	_transactionRequestBean.cardExpYY = _val[:cardExpYY]
  	_transactionRequestBean.timeOut = _val[:timeOut]  	
  	
  	_responseDetails = _transactionRequestBean.getTransactionToken
  	_responseDetails = Array(_responseDetails)
  	_response = _responseDetails[0]
  	_response.inspect
  	
  	if _response.match(/^msg=/i)
  		_response = "msg=#{_response.split("msg=").last}"  	
  		_outputStr = _response.gsub('msg=', '')
  		_outputArr = _outputStr.split('&')
  		_str = _outputArr[0]
  		_transactionResponseBean = TransactionResponseBean.new
  		_transactionResponseBean.responsePayload = _str
  		_transactionResponseBean.key = _val[:key]
  		_transactionResponseBean.iv = _val[:iv]
  		_response = _transactionResponseBean.getResponsePayload
  		_response.inspect  
  	elsif _response.match(/^txn_status=/i)	 
  		_response.inspect 
  	else
  		"<script>window.location = '#{_response}'</script>" 
  	end  	 
  else
	_response = params.to_s
	if params.is_a?(Hash)
	  _str = params[:msg]
	elsif _response.match(/msg=/i)
	  _response = "msg=#{_response.split("msg=").last}"  
	  _outputStr = _response.gsub('msg=', '')
	  _outputArr = _outputStr.split('&')
	  _str = _outputArr[0]
	else
	  _str = _response
	end
	
  	_transactionResponseBean = TransactionResponseBean.new
  	_transactionResponseBean.responsePayload = _str
  	_transactionResponseBean.key =session[:key]
  	_transactionResponseBean.iv = session[:iv]
  	
  	_response = _transactionResponseBean.getResponsePayload
  	"<p>#{_response.inspect}</p><a href=#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}>GO TO HOME</a>"
  	
  end  

end



