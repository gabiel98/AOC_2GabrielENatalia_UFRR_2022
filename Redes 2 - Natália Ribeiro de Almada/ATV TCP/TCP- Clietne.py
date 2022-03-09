import socket
host = '127.0.0.1' 
port = 7000 
addr = (host, port)

msgDoServidor       = "Olá, Cliente TCP"

#cria o  Socket para receber a conexão
tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 

tcp.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1) 

#define para qual IP e porta o servidor deve agardar a coexão
tcp.bind(addr) 

#define o limite de conexões
tcp.listen(10) 

print 'Aguardando Coexão...' 
#deixa o Servidor no aguardo das conexões
con, cliente = tcp.accept() 

print 'Conectado' 

print "Aguardando Mensagem..." 

recebe = con.recv(1024) 

print "Mensagem Do Servidor: "+ recebe tcp.close() 