// ****************************************
// Generated from .m file
// ****************************************


@interface XArray : NSMutableArray {
  NSMutableArray* _delegate;
}

id XArrayWith(id firstItem, ...);

+ (id) empty;
+ (id) from: (id)other;
+ (id) from: (id)other copyItems: (BOOL)copyItems;
+ (id) new;
+ (id) with: (id)firstItem vaList: (va_list)argList;
- (id) init;
- (id) initWith: (id)delegate;
- (id) initWith: (id)firstItem vaList: (va_list)argList;
- (id) initWithCapacity: (NSUInteger)numItems;
- (void) dealloc;
- (void) addObject: (id)anObject;
- (NSUInteger) count;
- (void) insertObject: (id)obj atIndex: (NSUInteger)index;
- (id) objectAtIndex: (NSUInteger)index;
- (void) removeObjectAtIndex: (NSUInteger)index;
- (void) removeLastObject;
- (void) replaceObjectAtIndex: (NSUInteger)index withObject: (id)anObject;
@end
