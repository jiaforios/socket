//
//  QFViewController.m
//  TCP连接
//
//  Created by Honey on 15/6/18.
//  Copyright (c) 2015年 Honey. All rights reserved.
//

#import "ZJViewController.h"

#import "AsyncSocket.h"     //专门处理tcp的数据发送
//#import "AsyncUdpSocket.h"  //专门处理udp的数据发送

@interface ZJViewController () <AsyncSocketDelegate>
{
    AsyncSocket *_tcpSocket;
    UITextField *host;
    UITextField *msg;
}

@end

@implementation ZJViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tcpSocket = [[AsyncSocket alloc] init];
    //要连接目标的port
    //必须要在连接之前设置代理
    _tcpSocket.delegate = self;

    
    //创建连接,异步操作
    //没有设置超时时间
    //    [_tcpSocket connectToHost:host onPort:port error:nil];
    
    //[_tcpSocket connectToHost:host onPort:port withTimeout:-1 error:nil];

    
    
    //要连接目标的ip
    
    host = [[UITextField alloc] initWithFrame:CGRectMake(10, 70, 250, 30)];
    
    host.borderStyle = UITextBorderStyleRoundedRect;
    
    host.placeholder = @"请输入你要连接的IP";
    host.text = @"192.168.1.104";
    
    [self.view addSubview:host];
    
    
    msg = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 250, 30)];
    
    msg.borderStyle = UITextBorderStyleRoundedRect;
    
    msg.placeholder = @"请输入你要发送的内容";
    
    [self.view addSubview:msg];

    
    UIButton *send = [UIButton buttonWithType:UIButtonTypeSystem];
    
    send.frame = CGRectMake(10, 200, 300, 50);
    
    [send setTitle:@"发送" forState:UIControlStateNormal];
    
    [send addTarget:self action:@selector(sendeMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:send];
}

- (void)sendeMessage
{
    //发送消息
    //1.网络数据都是二进制数据
    NSString *mesg = msg.text;
    
    NSData *data = [mesg dataUsingEncoding:NSUTF8StringEncoding];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        [_tcpSocket connectToHost:host.text onPort:8080 error:nil];

    });

    
    //2.发送数据
    [_tcpSocket writeData:data withTimeout:-1 tag:100];
}


//连接成功后调用的方法
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"连接成功");
    
    //连接成功之后才可以接收和发送数据
    //如果读取到数据,则会调用代理方法
    [_tcpSocket readDataWithTimeout:-1 tag:100];
    
}
//发送成功
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"发送成功");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //1.对接收到的数据进行处理
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", msg);
    
    //重复接收数据
    [_tcpSocket readDataWithTimeout:-1 tag:tag + 1];
}

- (void)dealloc
{
    [_tcpSocket disconnect]; //断开连接
}

@end






