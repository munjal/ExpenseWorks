#import "NSMutableString+X.h"

#import "XCore.h"

/*
#import "XCore.h"

@interface NSMutableString (X)
@end
*/

@implementation NSMutableString (X)

- (id) delete: (id)string {
  [self replaceOccurrencesOfString:string withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
  return self;
}

- (id) insert: (id)str at: (NSUInteger)index {
  [self insertString:str atIndex:index];
  return self;
}

- (id) prepend: (id)str {
  [self insertString:str atIndex:0];
  return self;
}

- (id) removeWhitespace {
  [self replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  [self replaceOccurrencesOfString:@"\t" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  [self replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  [self replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
  
  return self;
}

- (id) replace: (id)string with: (id)otherString {
  [self replaceOccurrencesOfString:string withString:otherString options:NSLiteralSearch range:NSMakeRange(0, [self length])];
  return self;
}

@end
