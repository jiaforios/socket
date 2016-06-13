//
//  GCDReceiver.m
//  udp_receiver
//
//  Created by qianfeng on 15-3-5.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import "GCDReceiver.h"
#import <netinet/in.h>
#import <arpa/inet.h>

#define kPort 9999 //监听数据的端口号

@implementation GCDReceiver
{
    GCDAsyncUdpSocket *_socket;
}

//绑定到默认端口
- (id)init
{
    return [self initWithBindPort:kPort];
}

//绑定到指定端口
- (id)initWithBindPort:(UInt16)port
{
    self = [super init];
    if (self)
    {
        _socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        [_socket bindToPort:port error:nil];
    }
    return self;
}

//开始接收数据
- (void)reciveMessage
{
    //开始接收消息
    [_socket beginReceiving:nil];
}


//接收数据
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    //将nsdata中的address --> sockaddr_in
    struct sockaddr_in  *socketAddress = nil;
    NSString            *socketString = nil;
    socketAddress = (struct sockaddr_in *)[address bytes];
    socketString = [NSString stringWithUTF8String:inet_ntoa(socketAddress->sin_addr)];

    NSLog(@"接收到来自:%@的消息:%@", socketString, message);
    
    
    
    //发送数据
    NSDictionary *info = @{@"message":message, @"address":socketString};
    
    [self sendMessage:info];
    
    //延时发送消息,测试重复接收数据
    [self performSelector:@selector(sendMessage:) withObject:info afterDelay:3];
    
   
    
}

- (void)sendMessage:(NSDictionary *)info
{
    NSString *message = info[@"message"];
    NSString *socketString = info[@"address"];
    NSString *send = [NSString stringWithFormat:@"这是你发的数据,还给你:%@", message];
    NSData *sendData = [send dataUsingEncoding:NSUTF8StringEncoding];
    
#warning  发送给客户端的数据，客户端默认接收端口为9998
    [_socket sendData:sendData toHost:socketString port:9998 withTimeout:-1 tag:0];
    
    NSLog(@"发送消息:%@", send);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"%ld 发送成功", tag);
}

@end





