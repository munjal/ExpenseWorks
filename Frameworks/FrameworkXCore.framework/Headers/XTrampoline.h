// ****************************************
// Generated from .m file
// ****************************************


@interface XTrampoline : NSProxy {
  id _bounceBackMethod;
  id _targetObject;
}
+ (id) with: (id)targetObject bounceBackMethodName: (id)bounceBackMethod;
- (id) initWith: (id)targetObject bounceBackMethodName: (id)bounceBackMethod;
- (void) dealloc;
- (id) bounceBackMethod;
- (void) forwardInvocation: (NSInvocation*)invocation;
- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector;
- (id) targetObject;
@end
