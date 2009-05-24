#import "NSMutableDictionary+X.h"
#import "XCore.h"

/*
@interface NSMutableDictionary (X)
@end
*/

@implementation NSMutableDictionary (X)

// initializer/class factory methods/constructors/destructor


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

// public instance methods

- (id) add: (id)key value:(id)value {
  [self setObject:value forKey:key];
  return self;
} 

- (id) addKey: (id)key withValue:(id)value {
  [self setObject:value forKey:key];
  return self;
} 

- (id) clone {
  return [self mutableCopyWithZone:nil];
}

- (id) clear {
  [self removeAllObjects];
  return self;
}

- (id) delete: (id)key {
  [self removeObjectForKey:key];
  return self;
}

- (id) dup { // z: it appears that we can't just alias clone because this is a category on NSMutableDictionary
  return [self clone];
}

- (id) empty {
  return [self clear];
}

- (BOOL) hasKey: (id)key {
  return [self objectForKey:key] != nil;
}

- (id) merge: (id)hash {
  [self addEntriesFromDictionary:hash];
  return self;
}

- (id) remove: (id)key {
  id value = [[self get:key] retain];
  [self removeObjectForKey:key];
  return [value autorelease];
}

- (id) set: (id)key to:(id)value {
	return [self add:key value:value];
}

@end
