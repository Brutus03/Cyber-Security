import argparse
import socket

def main():
    target_host = get_args()
    server_connect(target_host)

def get_args():
    parser = argparse.ArgumentParser() 
    parser.add_argument('-host', help='target host')
    parser.add_argument('-p', type=int, help='target port')
    args = parser.parse_args()

    return args

def server_connect(host):
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((host.host, host.p))
    client.send(b"GET / HTTP/1.1\r\nHost: host.host\r\n\r\n")
    response = client.recv(4096)
    
    print(response)

if __name__ == '__main__':
    main()