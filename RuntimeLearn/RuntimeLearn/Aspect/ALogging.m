//
//  ALogging.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "ALogging.h"

@implementation ALogging

typedef void (^AspectHandlerBlock)(id<AspectInfo> aspectInfo);

+ (void)setupWithConfiguration:(NSDictionary *)configs {
    // Hook Page Impression
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                       NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                       NSString *pageImp = configs[className][ALoggingPageImpression];
                                       if (pageImp) {
                                           NSLog(@"%@",pageImp);
                                       }
                                   });
                               }
                                    error:nil];
    
    // Hook Events
    for (NSString *className in configs) {
        Class class = NSClassFromString(className);
        NSDictionary *config = configs[className];
        
        if (config[ALoggingTrackedEvents]) {
            for (NSDictionary *event in config[ALoggingTrackedEvents]) {
                SEL selector = NSSelectorFromString(event[ALoggingEventSelectorName]);
                AspectHandlerBlock block = event[ALoggingEventHandlerBlock];
                
                [class aspect_hookSelector:selector
                               withOptions:AspectPositionAfter
                                usingBlock:^(id<AspectInfo> aspectInfo) {
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        block(aspectInfo);
                                    });
                                }
                                     error:nil];
            }
        }
    }
}

@end
