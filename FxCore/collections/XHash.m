#import "XHash.h"

#import "NSMutableDictionary+X.h"

/*
@interface XHash : NSMutableDictionary {
  id _delegate;
}

id XHashWith(id firstKey, ...);

@end
*/

id XHashWith(id firstKey, ...)  {
  va_list argList;
  va_start(argList, firstKey); 
  id instance = [XHash with:firstKey vaList:argList]; 
  va_end(argList);
  return instance;
}

@implementation XHash

// initializer/class factory methods/constructors/destructor

+ (void) initialize {
  [self aliasInstanceMethod:@"clone" as:@"dup"];
} 

+ (id) empty {
  return [[[self alloc] init] autorelease];
}

+ (id) from: (id)other {
  return [self from:other copyItems:NO];
}

+ (id) from: (id)other copyItems: (BOOL)copyItems {
  id delegate = [[[NSMutableDictionary alloc] initWithDictionary:other copyItems:copyItems] autorelease];
  return [[[self alloc] initWith:delegate] autorelease];
}

// todo: z: why not just have this be with:? or have both?
// takes a list of key, value, key2, value2, etc.
+ (id) withVargs: (id)firstKey, ... {
  id instance;
  if (firstKey) {
  	va_list argList; 
  	va_start(argList, firstKey);
    instance = [self with:firstKey vaList:argList];
  	va_end(argList); 
	}
  else {
    instance = [self empty];
  }
	return instance;	
}

+ (id) with: (id)firstKey vaList: (va_list)argList {
	id item;
	id instance = [self empty];
  int count = 1;	
	if (firstKey) {
	  id key = firstKey;
	  while (item = va_arg(argList, id)) {
	    if (count++ % 2 == 0) {
				key = item;		
	    }
	    else {
				[instance add:key value:item];
	    }
	  }
	}
	return instance;	
}

// constructors/destructors

- (id) init {
  id delegate = [[NSMutableDictionary alloc] init];
  id result = [self initWith:delegate];
  [delegate release];
  return result;
} 

// todo: z: rename this to initWithDelegate to avoid confusion; people are likely to think this is a copy constructor when it really isn't
- (id) initWith: (id)delegate {
	if (self = [super init]) {
    _delegate = [delegate retain];
  }
  return self;  
}

- (id) initWithCapacity: (NSUInteger) numItems {
	if (self = [super init]) {
    _delegate = [[NSMutableDictionary alloc] initWithCapacity:numItems];
  }
  return self;  
}

- (void) dealloc {   
	[_delegate release];
	[super dealloc]; 
} 

// these 5 methods need to be implemented to enable inheritance from NSMutableDictionary

- (id) clone {
  return [XHash from:self];
}

- (NSUInteger) count {
  return [_delegate count];
}

- (NSEnumerator*) keyEnumerator {
  return [_delegate keyEnumerator];
}

- (id) objectForKey: (id)key {
  return [_delegate objectForKey:key];
}

- (void) removeObjectForKey: (id)key {
  [_delegate removeObjectForKey:key];
}

- (void) setObject: (id)object forKey: (id)key {
  [_delegate setObject:object forKey:key];
}  
// end of methods that are needed for inheritance

@end
