$file:=File:C1566("/RESOURCES/models/nomic-embed-text-v1.5.f16.gguf")

var $llama : cs:C1710.llama.server
$llama:=cs:C1710.llama.server.new()
$llama.start({\
model: $file; \
embeddings: True:C214; \
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
