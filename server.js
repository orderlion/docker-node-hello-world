const http = require('http')

const port = 4000

const server = http.createServer((req, res) => {
  const host = req.headers.host;
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end(`Hello World!\nThe host you requested at is: ${host}`);
})

server.listen(port)

console.log('Server running at http://localhost:' + port)
