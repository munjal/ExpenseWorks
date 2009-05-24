#import "XTrampoline.h"

#import "XObject.h"
/*

@interface XTrampoline : NSProxy {
  id _bounceBackMethod;
  id _targetObject;
}
@end
*/

@implementation XTrampoline

+ (id) with: (id)targetObject bounceBackMethodName: (id)bounceBackMethod {
  return [[[self alloc] initWith:targetObject bounceBackMethodName:bounceBackMethod] autorelease];
}

// constructors/destructors

- (id) initWith: (id)targetObject bounceBackMethodName: (id)bounceBackMethod {
  if (self) {
    _targetObject = [targetObject retain];
    _bounceBackMethod = [bounceBackMethod retain];
  }
  return self;
}

- (void) dealloc { 
  [_bounceBackMethod release];
  [_targetObject release];
  [super dealloc]; 
}

// public instance methods

- (id) bounceBackMethod {
  return _bounceBackMethod;
}

- (void) forwardInvocation: (NSInvocation*)invocation {
  id returnValue = [_targetObject performSelector:NSSelectorFromString(_bounceBackMethod) withObject:invocation];
  [invocation setReturnValue:&returnValue];
}

- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector {
  return [_targetObject higherOrderMethodSignatureForSelector:selector];
}

- (id) targetObject {
  return _targetObject;
}

@end
