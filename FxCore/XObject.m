
#import <Foundation/Foundation.h>
#import </usr/include/objc/objc-class.h>
#import "XObject.h"
#import "XArray.h"
#import "XHash.h"
#import "XString.h"

/*
#import <Foundation/Foundation.h>

@interface XObject : NSObject {
    id _attributes;
    id _delegations;
}
@end
*/

// todo: z: need to make sure that XObject implements all of the Key-Value Coding interface correcty (http://developer.apple.com/documentation/Cocoa/Reference/Foundation/Protocols/NSKeyValueCoding_Protocol/Reference/Reference.html#//apple_ref/doc/uid/20000471-BABEHECF)
// e.g. attrReaders (without accessors won't be set correct in initWithHash:)

@implementation XObject

// initializer/class factory methods/constructors/destructor

- (id) init {
  if (self = [super init]) {
    _attributes = [[XHash alloc] init];
    _delegations = [[XHash alloc] init];
    [_delegations add:@"specificDelegations" value:[XHash empty]];
    [_delegations add:@"delegates" value:[XArray empty]];
  }
  return self;
}

// todo: z: needs to get _attributes and _delegations
- (id) initWithCoder: (id)coder {
  return [self init]; 
}

- (void) dealloc { 
  [_attributes release];
	[_delegations release];
	[super dealloc]; 
} 

// public class methods

+ (id) attrAccessors: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id array = [XArray with:firstItem vaList:argList];  
  va_end(argList);  
  return [self _attrAccessors:array];
}

+ (id) attrReaders: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id readableAttributes = [XArray with:firstItem vaList:argList];
  va_end(argList);   
  return [self _attrReaders:readableAttributes];
}

+ (id) attrWriters: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id writableAttributes = [XArray with:firstItem vaList:argList];
  va_end(argList);   
  return [self _attrWriters:writableAttributes];
}


// public instance methods

- (void) encodeWithCoder: (id)coder {
  // todo: z: needs to encode _attributes and _delegations
}

- (id) setValue: (id)value forUndefinedKey: (id)key {
  // NSLog(@"NSObject+X: not going to setValue %@ for key %@", value, key);
  return self;
}

// protected class methods

+ (id) _attrAccessors: (id)accessors {
  [self _attrReaders:accessors];
  [self _attrWriters:accessors];
  return self;
}

+ (id) _attrReaders: (id)readers {
  for (id item in readers) {
    [self aliasInstanceMethod:@"_getHashAttrByCmd" as:item];
  }
  return self;
}

+ (id) _attrWriters: (id)writers {
  for (id item in writers) {
    [self aliasInstanceMethod:@"_setHashAttrByCmd:" as:[XString withFormat:@"set%@:", [item asPascalCase], nil]];
  }
  return self;  
}

// protected instance methods

- (id) _attributes {
  return _attributes;
}

// z: undefined behavior if method is not of the form setX:
// todo: z: kill this here
- (id) _attributeSetterWithoutSetAndColon: (id)method {
  NSRange range;
  range.location = 3;
  range.length = [method length] - 4;
  return [[method substringWithRange:range] asCamelCase];
}

- (id) _delegates {
  return [_delegations get:@"delegates"];
}

- (BOOL) _hasDelegations {
  return YES;
}

- (id) _getHashAttrByCmd {
  id key = NSStringFromSelector(_cmd);
  if ([[self _attributes] containsKey:key]) {
    return [[self _attributes] get:key];
  }
  return nil;
}

- (id) _setHashAttrByCmd: (id)value {
  char buffer[128] = "";
  const char* selectorName = sel_getName(_cmd);
  int length = strlen(selectorName);
  // todo: z: what about memory consequences?
  strncpy(buffer, selectorName+3, length - 4);
  buffer[0] += 32;
  
  id key = [NSString stringWithUTF8String:buffer];
  if (value) {
    [[self _attributes] set:key to:value];
  }
  else {
    [[self _attributes] remove:key];
  }
  return self;
}

- (id) _delegations {
  return [_delegations get:@"specificDelegations"];
}

@end
