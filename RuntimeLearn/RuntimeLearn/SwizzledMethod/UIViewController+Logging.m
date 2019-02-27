//
//  UIViewController+Logging.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>
#import "Logging.h"
#import "Aspects.h"

@implementation UIViewController (Logging)

#pragma mark - swizzledSelector
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // the method might not exists in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn't exixt and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

//+ (void)load {
//    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
//}

- (void)swizzled_viewDidAppear:(BOOL)animated {
    // call original implementation
    [self swizzled_viewDidAppear:animated];
    
    // Logging
    [Logging logWithEventName:NSStringFromClass([self class])];
}

#pragma mark - Aspects
+ (void)load {
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                   
                                   [Logging logWithEventName:className];
    } error:nil];
}

#pragma mark - 这里还可以更简化点：直接用新的 IMP 取代原 IMP ，而不是替换。只需要有全局的函数指针指向原 IMP 就可以。
//void (gOriginalViewDidAppear)(id, SEL, BOOL);

//void newViewDidAppear(UIViewController *self, SEL _cmd, BOOL animated) {
//    // call original implementation
//    gOriginalViewDidAppear(self, _cmd, animated);
//
//    // Logging
//    [Logging logWithEventName:NSStringFromClass([self class])];
//}

//+ (void)load {
//    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidAppear:));
//    gOriginalViewDidAppear = (void *)method_getImplementation(originalMethod);
//
//    if(!class_addMethod(self, @selector(viewDidAppear:), (IMP) newViewDidAppear, method_getTypeEncoding(originalMethod))) {
//        method_setImplementation(originalMethod, (IMP) newViewDidAppear);
//    }
//}

@end
