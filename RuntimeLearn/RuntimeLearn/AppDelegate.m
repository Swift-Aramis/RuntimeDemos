//
//  AppDelegate.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AppDelegate+Logging.h"
#import "FishHookDemo.h"

typedef NS_ENUM(NSUInteger, TestType) {
    MethodSwizzled,
    Aspect,
    Fishhook,
};

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    TestType testType = Aspect;
    
    switch (testType) {
        case MethodSwizzled:
            [self setupLogging];
            break;
            
        case Aspect:
            [self setupMainRoot];
            [self setupLogging];
            break;
            
        case Fishhook:
            [self testFishhook];
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (void)setupMainRoot {
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
}

- (void)testFishhook {
    FishHookDemo *fishhookVC = [[FishHookDemo alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:fishhookVC];
    self.window.rootViewController = nav;
}

@end
