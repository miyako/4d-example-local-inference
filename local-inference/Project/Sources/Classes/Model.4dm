property URL : Text
property method : Text
property headers : Object
property dataType : Text
property automaticRedirections : Boolean
property file : 4D:C1709.File

Class constructor($file : 4D:C1709.File; $URL : Text)
	
	This:C1470.file:=$file
	This:C1470.URL:=$URL
	This:C1470.method:="GET"
	This:C1470.headers:={Accept: "application/vnd.github+json"}
	This:C1470.dataType:="blob"
	This:C1470.automaticRedirections:=True:C214
	
	If (OB Instance of:C1731(This:C1470.file; 4D:C1709.File))
		If (Not:C34(This:C1470.file.exists))
			If (This:C1470.file.parent#Null:C1517)
				This:C1470.file.parent.create()
				4D:C1709.HTTPRequest.new(This:C1470.URL; This:C1470)
			End if 
		Else 
			This:C1470.start()
		End if 
	End if 
	
Function start()
	
	var $llama : cs:C1710.llama.server
	$llama:=cs:C1710.llama.server.new()
	
	$llama.start({\
		model: This:C1470.file; \
		embeddings: True:C214; \
		pooling: "mean"; \
		ctx_size: 2048; \
		batch_size: 2048; \
		threads: 4; \
		threads_batch: 4; \
		threads_http: 4; \
		port: 8080; \
		temp: 0.7; \
		top_k: 40; \
		top_p: 0.9; \
		repeat_penalty: 1.1})
	
Function onResponse($request : 4D:C1709.HTTPRequest; $event : Object)
	
	If ($request.response.status=200) && ($request.dataType="blob")
		This:C1470.file.setContent($request.response.body)
		This:C1470.start()
	End if 
	
Function onError($request : 4D:C1709.HTTPRequest; $event : Object)
	