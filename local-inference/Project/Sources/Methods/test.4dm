//%attributes = {}
var $AIClient : cs:C1710.AIKit.OpenAI
$AIClient:=cs:C1710.AIKit.OpenAI.new()
$AIClient.baseURL:="http://127.0.0.1:8080/v1"

var $options : cs:C1710.AIKit.OpenAIEmbeddingsParameters
$options:=cs:C1710.AIKit.OpenAIEmbeddingsParameters.new()

var $responseModels : cs:C1710.AIKit.OpenAIModelListResult
$responseModels:=$AIClient.models.list()
If ($responseModels.success)
	var $ids : Collection
	$ids:=$responseModels.models.extract("id")
	If ($ids.length#0)
		$id:=$ids[0]
		
		var $text : Text
		$text:="We're goin' up, up, up It's our moment"
		
		var $responseEmbeddings : cs:C1710.AIKit.OpenAIEmbeddingsResult
		$responseEmbeddings:=$AIClient.embeddings.create($text; $id; $options)
		
	End if 
End if 
