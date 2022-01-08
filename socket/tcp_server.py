import argparse
import socket
import threading

def main():
    local_host = get_args()
    server_start(local_host)

def get_args():
    parser = argparse.ArgumentParser() 
    parser.add_argument('-i', help='bind ip')
    parser.add_argument('-p', type=int, help='bind port')
    args = parser.parse_args()

    return args

def server_start(host):
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((host.i, host.p))
    server.listen(5)

    print(f"[*] Listening on {host.i} {host.p}") 

    while True:
        client,addr = server.accept()
        
        print(f"[*] Accepted connection from: {addr[0]} {addr[1]}") 

        client_handler = threading.Thread(target=handle_client, args=(client,))
        client_handler.start()
    
def handle_client(client_socket):
    request = client_socket.recv(1024)

    print(f"[*] Received: {request}")

    client_socket.send(b"ACK!")
    client_socket.close() 

if __name__ == '__main__':
    main()