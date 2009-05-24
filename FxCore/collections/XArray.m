#import "XArray.h"

/*
@interface XArray : NSMutableArray {
  NSMutableArray* _delegate;
}

id XArrayWith(id firstItem, ...);

@end
*/

id XArrayWith(id firstItem, ...)  {
  va_list argList;
  va_start(argList, firstItem); 
  id instance = [XArray with:firstItem vaList:argList]; 
  va_end(argList);
  return instance;
}

@implementation XArray

// public class factory methods

+ (id) empty {
	return [[[self alloc] init] autorelease];
}

+ (id) from: (id)other {
  return [self from:other copyItems:NO];
}

+ (id) from: (id)other copyItems: (BOOL)copyItems {
  id delegate = [[[self alloc] initWithArray:other copyItems:copyItems] autorelease];
  return [[[self alloc] initWith:delegate] autorelease];
}

+ (id) new {
  return [[XArray alloc] init];
}

+ (id) with: (id)firstItem vaList: (va_list)argList {
  return [[[self alloc] initWith:firstItem vaList:argList] autorelease];
}

// constructors/destructors

- (id) init {
  return [self initWith:[[[NSMutableArray alloc] init] autorelease]];
}  

- (id) initWith: (id)delegate {
	if (self = [super init]) {
    _delegate = [delegate retain];
  }
  return self;
}  

- (id) initWith: (id)firstItem vaList: (va_list)argList {
  id item;
  id delegate = [[NSMutableArray alloc] init];
  if (firstItem) {
    [delegate addObject:firstItem];
    while (item = va_arg(argList, id)) {
      [delegate addObject:item];
    }
  }
  id array = [self initWith:delegate];
  [delegate release];
  return array;
}

- (id) initWithCapacity: (NSUInteger)numItems {
	id delegate = [[NSMutableArray alloc] initWithCapacity:numItems];
  return [self initWith:[delegate autorelease]];
}

- (void) dealloc { 
	[_delegate release];
	[super dealloc]; 
} 

// required methods to subclass NSMutableArray

- (void) addObject: (id)anObject {
	[_delegate addObject:anObject];
}

- (NSUInteger) count {
  return [_delegate count];
}

- (void) insertObject: (id)obj atIndex: (NSUInteger)index {
  [_delegate insertObject: obj atIndex: index];
}

- (id) objectAtIndex: (NSUInteger)index {
	return [_delegate objectAtIndex:index];
}

- (void) removeObjectAtIndex: (NSUInteger)index {
	[_delegate removeObjectAtIndex:index];
}

- (void) removeLastObject {
	[_delegate removeLastObject];
}

- (void) replaceObjectAtIndex: (NSUInteger)index withObject: (id)anObject {
	[_delegate replaceObjectAtIndex:index withObject:anObject];
}


@end