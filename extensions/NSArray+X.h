// ****************************************
// Generated from .m file
// ****************************************

#import "XTrampoline.h"

@interface NSArray (X)
+ (id) empty;
+ (id) withVargs: (id)firstItem, ...;
+ (id) with: (id)firstItem vaList: (va_list)argList;
- (id) _initWithVargs: (id)firstItem, ...;
- (id) _initWith: (id)firstItem vaList: (va_list)argList;
- (id) as2D: (int)sizeOfInnerArrays;
- (id) asHash;
- (id) at: (NSUInteger)index;
- (XTrampoline*) collect;
- (id) compact;
- (BOOL) contains: (id)object;
- (XTrampoline*) eachDo;
- (id) first;
- (id) from: (int)startIndex to: (int)endIndexInclusive;
- (id) from: (int)startIndex withLength: (int)length;
- (id) get: (NSUInteger)index;
- (id) higherOrderMethodSignatureForSelector:(SEL)selector;
- (BOOL) isEmpty;
- (BOOL) isNotEmpty;
- (id) join: (id)joiningString;
- (id) last;
- (NSUInteger) length;
- (id) map;
- (id) peek;
- (id) range: (NSRange)range;
- (XTrampoline*) reject;
- (id) sortBy: (id)selectorString;
- (NSUInteger) size;
- (id) top;
- (id) _collect: (id)invocation;
- (id) _doNothing;
- (id) _eachDo: (id)invocation;
- (id) _reject: (id)invocation;
@end
