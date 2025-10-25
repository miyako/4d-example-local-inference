![version](https://img.shields.io/badge/version-21%2B-3B69E9)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-example-local-inference)](LICENSE)

# 4d-example-local-inference
Use llama.cpp from 4D

[dependencies](https://github.com/miyako/4d-example-local-inference/blob/main/local-inference/Project/Sources/dependencies.json)

* [`miyako/llama-cpp`](https://github.com/miyako/llama-cpp)
* [`4d/4D-AIKit`](https://github.com/4d/4D-AIKit)
 
## instructions

download [nomic-embed-text-v1.5](https://huggingface.co/nomic-ai/nomic-embed-text-v1.5-GGUF) in GGUF format.

for a standard consumer PC, maybe `nomic-embed-text-v1.5.f16.gguf`, size `274,290,560` bytes (`286`MB)

* start `llama.cpp` locally

```4d
var $file : 4D.File
$file:=File("/RESOURCES/models/nomic-embed-text-v1.5.f16.gguf"; fk platform path)

var $llama : cs.llama.server
$llama:=cs.llama.server.new()
$llama.start({\
model: $file; \
embeddings: True; \
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
```

* generate embeddings

```4d
var $AIClient : cs.AIKit.OpenAI
$AIClient:=cs.AIKit.OpenAI.new()
$AIClient.baseURL:="http://127.0.0.1:8080/v1"

var $options : cs.AIKit.OpenAIEmbeddingsParameters
$options:=cs.AIKit.OpenAIEmbeddingsParameters.new()

$text:="Hello world"

$response:=$AIClient.embeddings.create($text; "nomic-embed-text-v1.5.f16.gguf"; $options)
```

* terminate `llama.cpp`

```4d
var $llama : cs.llama.server
$llama:=cs.llama.server.new()
$llama.terminate()
``` 
