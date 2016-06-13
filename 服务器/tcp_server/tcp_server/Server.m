//
//  Server.m
//  tcp_server
//
//  Created by foscom on 16/5/28.
//  Copyright © 2016年 Honey. All rights reserved.
//

#import "Server.h"
#import "GCDServer.h"
@interface Server ()

@property(nonatomic,strong)NSTextField *httptf;
@property(nonatomic,strong)NSTextField *porttf;
@property(nonatomic,strong)NSButton *creatBtn;
@end

@implementation Server



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.title = @"服务器";
    
    _httptf = [[NSTextField alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    _porttf = [[NSTextField alloc] initWithFrame:CGRectMake(10, 50, 100, 30)];
    
    
    _creatBtn = [[NSButton alloc] initWithFrame:CGRectMake(10, 100, 100, 50)];
    _creatBtn.title = @"创建连接";
    
    
    [_creatBtn setAction:@selector(creatAction)];
    
    [self.view addSubview:_httptf];
    [self.view addSubview:_porttf];
    [self.view addSubview:_creatBtn];
    

    
}


- (void)creatAction
{
//    _httptf.stringValue;
//    _porttf.stringValue;
    
    
    
    @autoreleasepool {
        
        GCDServer *s = [[GCDServer alloc] init];
        //开始监听端口，默认端口为宏定义 kPort 8888
        [s acceptClient];
        
        //指定监听端口
        //        [s acceptClientOnPort:9999];
        
        [[NSRunLoop currentRunLoop] run];
        
        
    }

    
    
}



@end
