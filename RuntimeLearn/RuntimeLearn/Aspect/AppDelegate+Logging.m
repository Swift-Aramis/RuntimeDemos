//
//  AppDelegate+Logging.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "AppDelegate+Logging.h"
#import "ALogging.h"

@implementation AppDelegate (Logging)

- (void)setupLogging {
    
    NSArray *mainEvents = @[
                            @{ALoggingEventName: @"buttonOneAction",
                              ALoggingEventSelectorName: @"buttonOneAction:",
                              ALoggingEventHandlerBlock: ^(id<AspectInfo> aspectInfo){
                                  NSLog(@"button one clicked");
                              }},
                            @{ALoggingEventName: @"buttonTwoAction",
                              ALoggingEventSelectorName: @"buttonTwoAction:",
                              ALoggingEventHandlerBlock: ^(id<AspectInfo> aspectInfo){
                                  NSLog(@"button two clicked");
                              }}
                            ];
    
    NSDictionary *config = @{@"MainViewController": @{ALoggingPageImpression: @"page imp - main page",
                                                      ALoggingTrackedEvents: mainEvents},
                             @"DetailViewController": @{ALoggingPageImpression: @"page imp - detail page"}};

    [ALogging setupWithConfiguration:config];
}

@end
