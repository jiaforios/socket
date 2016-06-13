//
//  main.m
//  udp_receiver
//
//  Created by qianfeng on 15-3-5.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GCDReceiver.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //绑定到默认端口 kPort 9999
        //GCDReceiver *r = [[GCDReceiver alloc] init];
        //绑定到指定端口
        GCDReceiver *r = [[GCDReceiver alloc] initWithBindPort:9999];
        
        //开始接收数据
        [r reciveMessage];
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}

