//
//  GCDReceiver.h
//  udp_receiver
//
//  Created by qianfeng on 15-3-5.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

@interface GCDReceiver : NSObject <GCDAsyncUdpSocketDelegate>

//绑定到默认端口
- (id)init;

//绑定到指定端口
- (id)initWithBindPort:(UInt16)port;

//开始接收数据
- (void)reciveMessage;


@end
