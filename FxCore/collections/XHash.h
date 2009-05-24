// ****************************************
// Generated from .m file
// ****************************************


@interface XHash : NSMutableDictionary {
  id _delegate;
}

id XHashWith(id firstKey, ...);

+ (void) initialize;
+ (id) empty;
+ (id) from: (id)other;
+ (id) from: (id)other copyItems: (BOOL)copyItems;
+ (id) withVargs: (id)firstKey, ...;
+ (id) with: (id)firstKey vaList: (va_list)argList;
- (id) init;
- (id) initWith: (id)delegate;
- (id) initWithCapacity: (NSUInteger) numItems;
- (void) dealloc;
- (id) clone;
- (NSUInteger) count;
- (NSEnumerator*) keyEnumerator;
- (id) objectForKey: (id)key;
- (void) removeObjectForKey: (id)key;
- (void) setObject: (id)object forKey: (id)key;
@end
