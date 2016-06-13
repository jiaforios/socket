//
//  GCDServer.m
//  tcp_server
//
//  Created by qianfeng on 15-3-5.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import "GCDServer.h"

#define kPort 8888 //监听数据的端口号

@implementation GCDServer
{
    GCDAsyncSocket *_socket;
}

- (id)init
{
    if (self = [super init])
    {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    return self;
}

//监听端口,默认为8888
- (void)acceptClient
{
    [self acceptClientOnPort:kPort];
}

//监听指定端口
- (void)acceptClientOnPort:(UInt16)port
{
    NSError *error;
    if ([_socket acceptOnPort:port error:&error])
    {
        NSLog(@"监听端口【%d】成功", port);
    }
    else
    {
        NSLog(@"监听端口【%d】失败, 原因:%@", port, [error localizedDescription]);
    }
}

//客户端和服务端成功建立连接

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"与客户端 %@ 成功建立连接", newSocket.connectedHost);
    //发送数据给客户端
    [newSocket writeData:[@"约吗?来自星星的你" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    //读取客户端发送的数据
    [newSocket readDataWithTimeout:-1 tag:100];
}

//数据发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"发送成功:%ld", tag);
}

//接收到来自客户端的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@ from client:%@", sock.connectedHost, s);
    
    NSString *send = [@"这是你给我的消息,还给你:" stringByAppendingString:s];
    [sock writeData:[send dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    //重复接收数据
    [sock readDataWithTimeout:-1 tag:0];
    
}


@end
