//
//  Message.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "Message.h"
#import <objc/runtime.h>
#import "MessageForwarding.h"

@implementation Message

#pragma mark - Normal Way

//- (void)sendMessage:(NSString *)word {
//    NSLog(@"normal way : send message = %@",word);
//}

#pragma mark - Method Resolution
/// override resolveInstanceMethod or resolveClassMethod for changing sendMessage method implementation

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(sendMessage:)) {
//
////        class_addMethod([Class  _Nullable __unsafe_unretained cls], SEL  _Nonnull name, IMP  _Nonnull imp, const char * _Nullable types)
//
//        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, NSString *word) {
//            NSLog(@"method resolution way : send message = %@", word);
//        }), "v@*");
//
//        /**
//         注意到上面代码有这样一个字符串"v@*"，它表示方法的参数和返回值，详情请参考Type Encodings
//         https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
//
//         如果resolveInstanceMethod方法返回NO，运行时就跳转到下一步：消息转发(Message Forwarding)
//         */
//    }
//    return YES;
//}

#pragma mark - Fast Forwarding

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(sendMessage:)) {
//        return [[MessageForwarding alloc] init];
//
//        /**
//         如果目标对象实现 -forwardingTargetForSelector: 方法，系统就会在运行时调用这个方法，
//         只要这个方法返回的不是 nil 或 self，也会重启消息发送的过程，把这消息转发给其他对象来处理。
//         */
//    }
//    return nil;
//}

#pragma mark - Normal Forwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    MessageForwarding *messageForwarding = [[MessageForwarding alloc] init];
    if ([messageForwarding respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:messageForwarding];
    }
}

@end
