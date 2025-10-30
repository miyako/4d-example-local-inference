//%attributes = {}
var $AIClient : cs:C1710.AIKit.OpenAI

var $keyFile : 4D:C1709.File
$keyFile:=Folder:C1567(Folder:C1567("/PACKAGE/").platformPath; fk platform path:K87:2).parent.file("OpenAI.token")
If ($keyFile.exists)
	$AIClient:=cs:C1710.AIKit.OpenAI.new($keyFile.getText())
Else 
	$AIClient:=cs:C1710.AIKit.OpenAI.new()
	$AIClient.baseURL:="http://127.0.0.1:8080/v1"
End if 

var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()

var $responseModels : cs:C1710.AIKit.OpenAIModelListResult
$responseModels:=$AIClient.models.list()
If ($responseModels.success)
	var $models : Collection
	$models:=$responseModels.models.query("id in :1"; ["text-embedding-3-small"; "@.gguf"])
	If ($models.length#0)
		
		var $model : Text
		$model:=$models.first().id
		
		var $text : Text
		$text:="4D 21でローカルAIを使用するためのコンポーネント"
		
		var $responseEmbeddings : cs:C1710.AIKit.OpenAIEmbeddingsResult
		$responseEmbeddings:=$AIClient.embeddings.create($text; $model; $options)
		
	End if 
End if 
