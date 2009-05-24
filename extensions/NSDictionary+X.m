#import "NSDictionary+X.h"

#import "XCore.h"

/*
@interface NSDictionary (X)
@end
*/

@implementation NSDictionary (X)

// initializer/class factory methods/constructors/destructor

ALIAS(keys, allKeys);

+ (id) atPath: (id)path {
  return [[[self alloc] initWithContentsOfFile:path] autorelease];
}

+ (id) empty {
  return [[[self alloc] init] autorelease];
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
  id keys = [XArray empty];
  id values = [XArray empty];
  int count = 1; 
  if (firstKey) {
    [keys add:firstKey];
    while (item = va_arg(argList, id)) {
      if (count++ % 2 == 0) {
        [keys add:item];
      }
      else {
        [values add:item];
      }
    }
  }
 return [self dictionaryWithObjects:values forKeys:keys];  
}

// public instance methods

- (id) asQueryString {
	id queryStringComponents = [XArray empty];
	for (id key in self) {
    if ([[self get:key] isa:[NSArray class]]) {
      if ([[self get:key] isEmpty]) {
        [queryStringComponents add:[XString withFormat:@"%@=", key]];
      }
	    for(id value in [self get:key]) {
	      [queryStringComponents add:[XString withFormat:@"%@=%@", key, value]];
	    }        
	  }
	  else {
	    [queryStringComponents add:[XString withFormat:@"%@=%@", key, [self get:key]]];	
	  }
	}
  return [[queryStringComponents join:@"&"] urlEncoded];  
}

- (id) clone {
  // z: this method never seems to be called because NSMutable dictionary has its own version and the class cluster stuff seems to always use it
  return [self copyWithZone:nil];
}

- (BOOL) contains: (id)key {
  return [self containsKey:key];
}

- (BOOL) containsKey: (id)key {
  return [self hasKey:key];
}

- (id) get: (id)key {
  return [self objectForKey:key];
}

- (BOOL) hasKey: (id)key {
  return [self objectForKey:key] != nil;
}

- (BOOL) isEmpty {
  return [self count] == 0;
}

// todo: z: implement a values method as alias of allValues

- (id) without: (id)firstKey, ... {
  va_list argList; 
  va_start(argList, firstKey);
  id keysToExclude = [XArray with:firstKey vaList:argList];
  va_end(argList); 
  return [self withoutKeys:keysToExclude];
}

- (id) withoutKey: (id)key {
  return [[XHash dictionaryWithDictionary:self] delete:key];
}

- (id) withoutKeys: (id)keysToExclude {
  id result = [XHash empty];
  for (id key in self) {
    if (![keysToExclude contains:key]) {
      [result add:key value:[self get:key]];
    }
  }
  return result;
}

@end
