//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	var $lang; $URL : Text
	var $file : 4D:C1709.File
	$lang:=Get database localization:C1009(Current localization:K5:22)
	Case of 
		: ($lang="ja")
			$file:=File:C1566("/RESOURCES/models/elyza_Llama-3-ELYZA-JP-8B-GGUF_Llama-3-ELYZA-JP-8B-q4_k_m.gguf")
			$URL:="https://huggingface.co/elyza/Llama-3-ELYZA-JP-8B-GGUF/resolve/main/Llama-3-ELYZA-JP-8B-q4_k_m.gguf"
		Else 
			$file:=File:C1566("/RESOURCES/models/nomic-embed-text-v1.5.f16.gguf")
			$URL:="https://github.com/miyako/4d-example-pdf-chunking/releases/download/nomic-embed-text-v1.5.f16.gguf/nomic-embed-text-v1.5.f16.gguf"
	End case 
	CALL WORKER:C1389(Current method name:C684; Current method name:C684; {lang: $lang; file: $file; URL: $URL})
Else 
	
	var $model : cs:C1710.Model
	$model:=cs:C1710.Model.new($params.file; $params.URL)
	
End if 