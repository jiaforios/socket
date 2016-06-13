//
//  GCDServer.h
//  tcp_server
//
//  Created by qianfeng on 15-3-5.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
@interface GCDServer : NSObject <GCDAsyncSocketDelegate>



//默认端口 8888
- (void)acceptClient;

//指定端口
- (void)acceptClientOnPort:(UInt16)port;

@end
