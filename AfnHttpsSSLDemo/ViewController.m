//
//  ViewController.m
//  AfnHttpsSSLDemo
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //这里访问的是http协议网站压根不能验证 
//    [HttpRequest post:@"http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json" params:nil success:^(id responseObj) {
//        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil];
//        NSLog(@"===============%@",dictData);
//    } failure:^(NSError *error) {
//        
//    }];
    [HttpRequest post:@"https://www.baidu.com" params:nil success:^(id responseObj) {
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil];
        NSLog(@"===============%@",dictData);
    } failure:^(NSError *error) {
        NSLog(@"===============%@",error
              );
    }];
    
    //苹果ATS（App Transport Security）只信任知名CA颁发的证书，所以在iOS9下即使是HTTPS请求还是会被ATS拦截。 注意修改Info.plist中添加NSAppTransportSecurity类型Dictionary，在NSAppTransportSecurity下添加NSAllowsArbitraryLoads，Boolean为YES。
    
    
//    我前面说过，验证站点证书，是通过域名的，如果服务器端站点没有绑定域名（万恶的备案），仅靠IP地址上面的方法是绝对不行的。怎么办？答案是想通过设置是不可以的，你只能修改AFNetworking2的源代码！打开AFSecurityPolicy.m文件，找到方法：
//    
//    - (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
//forDomain:(NSString *)domain
//    将下面这部分注释掉
//    
//    //            SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)pinnedCertificates);
//    //
//    //            if (!AFServerTrustIsValid(serverTrust)) {
//    //                return NO;
//    //            }
//    //
//    //            if (!self.validatesCertificateChain) {
//    //                return YES;
//    //            }
//    这样，AFSecurityPolicy就只会比对服务器证书和内嵌证书是否一致，不会再验证证书是否和站点域名一致了。
//    
//    　　这么做为什么是安全的？了解HTTPS的人都知道，整个验证体系中，最核心的实际上是服务器的私钥。私钥永远，永远也不会离开服务器，或者以任何形式向外传输。私钥和公钥是配对的，如果事先在客户端预留了公钥，只要服务器端的公钥和预留的公钥一致，实际上就已经可以排除中间人攻击了。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
