//
//  ViewController.m
//  BeStronger
//
//  Created by Roy on 16/11/23.
//  Copyright © 2016年 Roy. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>


@property(strong,nonatomic) NSMutableData *datass;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!self.datass) {
        self.datass=[NSMutableData data];
    }
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"willAppear");
    [super viewWillAppear:animated];
    //新增按钮
    UIButton *infoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton setTitle:@"获取信息" forState:UIControlStateNormal];
    CGRect rect=CGRectMake(self.view.frame.size.width-600/2, self.view.frame.size.height-100, 200, 50);
    infoButton.frame=rect;
    NSLog(@"button frame:%@",infoButton.frame);
    infoButton.backgroundColor=[UIColor blueColor];
    infoButton.titleLabel.textColor=[UIColor whiteColor];
    
    [self.view addSubview:infoButton];
    [infoButton addTarget:self action:@selector(getInfo:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getInfo:(UIButton *) button
{
    NSLog(@"%@",[button titleLabel].text);
    //获取一个请求对象
  //NSURL *url=[NSURL URLWithString:@"http://192.168.1.101:8080/testEmp?id=10"];
    NSURL *url=[NSURL URLWithString:@"http://192.168.31.123:8080/testEmp?id=10"];
//    NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 协议

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response:%@",response);

}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
   
    [self.datass appendData:data];
  
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"网络请求结束。connection:%@",connection);
   // NSDictionary *obj=nil;
    
    NSError *error=nil;
    if (self.datass!=nil) {
    NSDictionary     *obj=[NSJSONSerialization JSONObjectWithData:self.datass options:0 error:&error];
        if(error!=nil)NSLog(@"error:%@",error);
        if (obj==nil) {
            NSLog(@"obj is null");
            return;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSLog(@"dictionary");
            NSDictionary *empDic=[obj objectForKey:@"emp"];
            NSString *name=[NSString stringWithString:[[empDic valueForKey:@"name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            self.nameTextField.text=[empDic valueForKey:@"name"];
            self.birthdayTextField.text=[empDic valueForKey:@"birthDay"];
            NSLog(@"%d",[[empDic objectForKey:@"id"] intValue]);
            NSNumber *number=[NSNumber numberWithLong:[empDic valueForKey:@"id"] ];
            self.departTextField.text=[number stringValue];
            self.idTextField.text= [NSString stringWithFormat:@"%d",[[empDic valueForKey:@"id"]intValue]];
            //self.departTextField.text=[empDic objectForKey:@"dept"];
        }else if([obj isKindOfClass:[NSArray class]]){
            NSLog(@"array");
        }else if ([obj isKindOfClass:[NSString class]]){
            NSLog(@"string");
        }
        NSLog(@"json:%@",obj);
    }
    
};

#pragma mark  懒加载
//-(NSMutableData *) datas
//{
//    if (self.datass==nil) {
//        self.datass=[NSMutableData data];
//    }
//    return self.datas;
//}

@end
