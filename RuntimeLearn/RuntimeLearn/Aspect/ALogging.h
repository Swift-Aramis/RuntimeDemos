//
//  ALogging.h
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Aspects.h"

/// keys
#define ALoggingPageImpression @"ALoggingPageImpression"
#define ALoggingTrackedEvents @"ALoggingTrackedEvents"
#define ALoggingEventName @"ALoggingEventName"
#define ALoggingEventSelectorName @"ALoggingEventSelectorName"
#define ALoggingEventHandlerBlock @"ALoggingEventHandlerBlock"

NS_ASSUME_NONNULL_BEGIN

@interface ALogging : NSObject

+ (void)setupWithConfiguration:(NSDictionary *)configs;

@end

NS_ASSUME_NONNULL_END
