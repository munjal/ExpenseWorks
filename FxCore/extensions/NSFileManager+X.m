#import "NSFileManager+X.h"
#import "FrameworkX.h"

/*
@interface NSFileManager (X)
@end
*/


@implementation NSFileManager (X)

- (BOOL) removeItemAtPathAndLogError: (id)path {
  id error = nil;
  BOOL success = [self removeItemAtPath:path error:&error];
  if (!success) {
    id errorMessage = [XString withFormat:@"Unable to delete file at: %@", path, nil];
    if (error) {
      [errorMessage append:[XString withFormat:@" Error: %@", error, nil]];
    }
    NSLog(errorMessage);
  }
  return success;
}
@end
