
#import "XMethod.h"
#import "Macros.h"
#import "XString.h"

/*
#import "XObject.h"
#import </usr/include/objc/objc-class.h>

@interface XMethod : XObject {
  Method _method;
  id _owningObject;
}
@end
*/

@implementation XMethod

// public class methods

+ (id) with: (Method)method from: (id)owningObject {
  return [[[XMethod alloc] initWith:method from:owningObject] autorelease];
}

+ (id) withName: (id)methodName from: (id)owningObject {
  Method method = class_getInstanceMethod([owningObject class], [methodName asSelector]);
  return [self with:method from:owningObject];
}

// constructors/destructors

- (id) initWith: (Method)method from: (id)owningObject {
  if (self = [super init]) {
    _method = method;
    _owningObject = [owningObject retain];
  }
  return self;
}

- (void) dealloc { 
	[_owningObject release];
	[super dealloc]; 
} 


// public instance methods

- (id) description {
  return [self methodName];
}

- (IMP) imp {
  if (_method) {
    return method_getImplementation(_method);
  }
  return NULL;
}

- (Method) method {
  return _method;
}

- (id) methodName {
  if (_method) {
     return [XString withFormat:@"%s", [self selector]];
   }
   return @"XMethod with underlying method null";
}

- (const char*) methodTypes {
  if (_method) {
    return method_getTypeEncoding(_method);
  }
  return NULL;  
}

- (id) owningObject {
  return _owningObject;
}

- (id) returnType {
  char* returnTypeAsCString = method_copyReturnType(_method);
  id returnType = [XString fromCString:returnTypeAsCString];
  free(returnTypeAsCString);
  return returnType;
}

- (SEL) selector {
  if (_method) {
    return method_getName(_method);
  }
  return NULL;
}

// todo: z: this should compare the methodTypes too
- (BOOL) isEqual: (id)other {
  if (isNilOrNull(other)) {
    return NO;
  }
  Method other_method = [other method];
  BOOL underlyingMethodsEqual = _method == NULL && other_method == NULL;
  if (_method != NULL && other_method != NULL) {
    underlyingMethodsEqual = [NSStringFromSelector(method_getName(_method)) isEqual:NSStringFromSelector(method_getName(other_method))]
      && method_getImplementation(_method) == method_getImplementation(other_method);
  }
  return underlyingMethodsEqual
    && equalOrBothNil(_owningObject, [other owningObject]);
}

@end
