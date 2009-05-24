#import "NSInvocation+X.h"
#import "XCore.h"

/*
#import "XCore.h"

@interface NSInvocation (X)
@end
*/

@implementation NSInvocation (X)

- (id) returnValueAfterInvokingOn: (id) target {
    id returnValue;
    [self invokeWithTarget:target];
    [self getReturnValue:&returnValue];
    return returnValue;
}


@end
