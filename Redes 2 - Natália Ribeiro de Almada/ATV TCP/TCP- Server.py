import socket 
msgDoCliente       = "Olá, ServidorTCP"

ip = raw_input('Informe o IP: ') 
port = 7000 
addr = ((ip,port)) 

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
# conexão com o servidor
client_socket.connect(addr) 
mensagem = raw_input("Digite a mensagem para o servidor: ") 
#faz envio de dado paa servidor
client_socket.send(mensagem) 

print 'Mensagem Enviada. Obrigada.' 
#fecha a conexão entre as aplicacoes.
client_socket.close()