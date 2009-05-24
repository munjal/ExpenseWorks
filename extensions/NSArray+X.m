#import "NSArray+X.h"
#import "XCore.h"

/*
#import "XTrampoline.h"

@interface NSArray (X)
@end
*/


@implementation NSArray (X)

// public class methods

+ (id) empty {
  return [[[self alloc] init] autorelease];
}

+ (id) withVargs: (id)firstItem, ... {
  id array;
  if (firstItem) {
    va_list argList; 
    va_start(argList, firstItem);
    array = [self with:firstItem vaList:argList];
    va_end(argList); 
  }
  else {
    array = [self empty];
  }
  return array;
}

+ (id) with: (id)firstItem vaList: (va_list)argList {
  return [[[self alloc] _initWith:firstItem vaList:argList] autorelease];
}

// z: this is _initWithVargs because if it were initWithVargs, it would be overridden by NSMutableArray+X's version due to class-cluster hierarchy ugliness that I don't quite understand
- (id) _initWithVargs: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id array = [self _initWith:firstItem vaList:argList];
  va_end(argList); 
  return array;
}

// z: this is _initWith because the built-in initWith (no underscore) inexplicably does not work properly for immutable arrays
- (id) _initWith: (id)firstItem vaList: (va_list)argList {
  id item;
  id array = [[XArray alloc] init];
  if (firstItem) {
    [array addObject:firstItem];
    while (item = va_arg(argList, id)) {
      [array addObject:item];
    }
  }
  id returnValue = [self initWithArray:array];
  [array release];
  return returnValue;
}


// public instance methods

- (id) as2D: (int)sizeOfInnerArrays {
  if ([self isEmpty]) {
    return [XArray empty]; // z: this should return an NSArray, but the class cluster stuff seems to break when trying to return [self empty]
  }
  if (sizeOfInnerArrays < 1) {
    @throw [NSException with:@"can't call this method with columSize < 1"];
  }
  int numArraysRequired = [self count] / sizeOfInnerArrays;
  if ([self count] % sizeOfInnerArrays != 0) {
    numArraysRequired++;
  }
  id array2D = [XArray empty]; // z: this should be a generic mutable array
  id arrayForColumn;
  int indexIntoSelf;
  for (int row = 0 ; row < numArraysRequired; row++) {
    arrayForColumn = [XArray empty];
    [array2D add:arrayForColumn];
    for (int col = 0; col < sizeOfInnerArrays; col++) {
      indexIntoSelf = (row * sizeOfInnerArrays) + col;
      if (indexIntoSelf == [self count]) {
        break;
      }
      [arrayForColumn add:[self at:indexIntoSelf]];
    }
  }
  return array2D;
}

- (id) asHash {
  id result = [XHash empty];
  int count = 0;	
	id key;
  for (id item in self) {
    if (count++ % 2 == 0) {
      key = item;    
    }
    else {
      [result add:key value:item];
    }    
  }
  return result;
}

- (id) at: (NSUInteger)index {
  if ([self count] <= index) return nil;  
  return [self objectAtIndex:index];
}

- (XTrampoline*) collect {
  return [XTrampoline with:self bounceBackMethodName:@"_collect:"];
}

- (id) compact {
  id result = [XArray empty];
  for (id value in self) {
    if (![value isEqual:nullObject]) {
      [result add:value];
    }
  }
  return result;
}

- (BOOL) contains: (id)object {
  return [self containsObject:object];
}

- (XTrampoline*) eachDo {
  return [XTrampoline with:self bounceBackMethodName:@"_eachDo:"];
}

- (id) first {
  if ([self count] == 0) return nil;
  return [self at:0];
}

- (id) from: (int)startIndex to: (int)endIndexInclusive {
  return [self range:NSMakeRange(startIndex, endIndexInclusive - startIndex + 1)];
}

- (id) from: (int)startIndex withLength: (int)length {
  return [self range:NSMakeRange(startIndex, length)];
}

- (id) get: (NSUInteger)index {
  return [self at:index];
}


- (id) higherOrderMethodSignatureForSelector:(SEL)selector {
  if ([self isEmpty]) {
    return [self methodSignatureForSelector:@selector(_doNothing)];
  }
  return [[self first] methodSignatureForSelector:selector];
}

- (BOOL) isEmpty {
  return [self count] == 0;
}

- (BOOL) isNotEmpty {
  return [self count] > 0;
}

- (id) join: (id)joiningString {
	if ([self count] == 0) return [XString empty];
  id result = [XString withFormat: @"%@", [self objectAtIndex:0]];	
	id enumerator = [self objectEnumerator];
	id anObject = [enumerator nextObject]; // burn the first object
	while (anObject = [enumerator nextObject]) {
    id str = [XString withFormat:@"%@%@", joiningString, anObject];
    result = [result append:str];
	}	
	return result;
}

- (id) last {
  if ([self count] == 0) return nil;
  return [self at:[self count] - 1];
}

- (NSUInteger) length {
  return [self count];
}

- (id) map {	
  return [self collect];
}

- (id) peek {
  return [self top];
}

- (id) range: (NSRange)range {
  return [self subarrayWithRange:range];
}

- (XTrampoline*) reject {
  return [XTrampoline with:self bounceBackMethodName:@"_reject:"];
}

- (id) sortBy: (id)selectorString {
  id contentDescriptor = [[NSSortDescriptor alloc] initWithKey:selectorString
                                             ascending:YES];
  id sortDescriptors = [XArray withVargs:contentDescriptor, nil];
  return [self sortedArrayUsingDescriptors:sortDescriptors];  		
}

- (NSUInteger) size {
  return [self count];
}

- (id) top {
  return [self at:0];
}

// protected instance methods

- (id) _collect: (id)invocation {
  id newArray = [XArray empty];
  for (id item in self) {
    id returnValue = [invocation returnValueAfterInvokingOn:item];
    if (returnValue) {      
      [newArray append:returnValue];
    }
    else {
      [newArray append:nullObject];
    }
  }
  return newArray;
}

- (id) _doNothing {
  return self;
}

- (id) _eachDo: (id)invocation {
  for (id item in self) {
    [invocation invokeWithTarget:item];
  }
  return self;
}

- (id) _reject: (id)invocation {
  id newArray = [XArray empty];
  for (id item in self) {
    id returnValue = [invocation returnValueAfterInvokingOn:item];
    if ([returnValue isFalse]) {      
      [newArray append:item];
    }
  }
  return newArray;
}


@end
