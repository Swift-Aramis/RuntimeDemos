//
//  FishHookDemo.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/27.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "FishHookDemo.h"
#import "fishhook.h"

@interface FishHookDemo ()

@end

@implementation FishHookDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Touch my background";
    
#pragma mark - hook 系统 NSLog
    //1.定义rebinding结构体
    /**
     struct rebinding {
     const char *name;
     void *replacement;
     void **replaced;
     };
     */
    struct rebinding rebind = {};
    rebind.name = "NSLog";
    
#warning - Test - 替换自己定义的C函数
//    rebind.name = "funcDLog";

    rebind.replacement = hookNSLog;
    rebind.replaced = (void *)&nslogMethod;
    
    //2.将上面的结构体 放入 reb结构体数组中
    struct rebinding red[] = {rebind};
    /*
     * arg1 : 结构体数据组
     * arg2 : 数组的长度
     */
    rebind_symbols(red, 1);
}

//定义一个函数指针 用于指向原来的NSLog函数
static void (*nslogMethod)(NSString *format, ...);

void hookNSLog(NSString *format, ...) {
    format = [format stringByAppendingString:@" - hooked"];
    nslogMethod(format);
}

#warning - Test - 自己定义的C函数
void funcDLog(NSString *format, ...) {
    NSLog(@"%@", format);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     void NSLog(NSString *format, ...)
     */
    NSLog(@"origin NSLog function");
    
#warning - Test - 替换自己定义的C函数
    // 测试结果：无法被hook
//    funcDLog(@"func Dlog");
}

@end
