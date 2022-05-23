require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'kadai.html.erb')
# この一行を追記
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

# この一行を追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.mount('/goya2.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya2.rb')

server.mount('/goya3.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya3.rb')

server.start