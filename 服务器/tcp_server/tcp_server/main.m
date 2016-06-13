//
//  main.m
//  tcp_server
//
//  Created by Honey on 15/3/4.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "GCDServer.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        GCDServer *s = [[GCDServer alloc] init];
        //开始监听端口，默认端口为宏定义 kPort 8888
        [s acceptClient];
        
        //指定监听端口
//        [s acceptClientOnPort:9999];
        
        [[NSRunLoop currentRunLoop] run];
        
        
    }
    return 0;
}

