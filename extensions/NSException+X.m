#import "NSException+X.h"
#import "FrameworkX.h"
/*

@interface NSException (X)
@end
*/

@implementation NSException (X)

+ (id) with: (id)reason {
  return [[self class] exceptionWithName:[XString withFormat:@"Bond... James Bond. (%@)", [self class]] reason:reason userInfo:nil];
}

@end
