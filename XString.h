// ****************************************
// Generated from .m file
// ****************************************

#import "NSString+X.h"
#import "NSMutableString+X.h"

@interface XString : NSMutableString {
  id _delegate;
}
+ (id) empty;
- (id) init;
- (id) initWithBytes:(const void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding;
- (id) initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)flag;
- (id) initWithCapacity: (unsigned int)capacity;
- (id) initWithCharactersNoCopy: (unichar*)chars length: (unsigned int)length freeWhenDone: (BOOL)flag;
- (id) initWithContentsOfFile: (id) path;
- (id) initWithContentsOfFile: (NSString*)path encoding: (NSStringEncoding)enc error: (NSError**)error;
- (id) initWithCString: (const char*)nullTerminatedCString encoding: (NSStringEncoding)encoding;
- (id) initWithFormat: (NSString*)format, ...;
- (id) initWithFormat: (NSString*)format arguments:(va_list)argList;
- (void) dealloc;
- (id) append: (id)string;
- (unichar) characterAtIndex: (NSUInteger)index;
- (id) description;
- (NSUInteger) length;
- (void) replaceCharactersInRange: (NSRange)range withString:(NSString*)string;
- (NSUInteger) replaceOccurrencesOfString: (NSString*)target withString: (NSString*)replacement options: (NSStringCompareOptions)opts range: (NSRange)searchRange;
- (void) setString: (NSString*)string;
@end
