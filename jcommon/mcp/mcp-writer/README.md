"writer-mcp": {
"command": "java",
"args": [
"-jar",
"-DDEEPSEEK_API_KEY=123456",
"/Users/zhangzhiyong/IdeaProjects/open/mone/jcommon/mcp/mcp-writer/target/app.jar"
]
}

 "mcp_writer": {
      "type": "grpc",
      "sseRemote": true,
      "env": {
        "port": "9786"
      }
    }