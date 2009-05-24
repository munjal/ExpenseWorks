#import "NSObject+X.h"
#import </usr/include/objc/objc-class.h>
#import "XCore.h"
#import "_XParameterSet.h"


// todo: z: add attrXs to NSObject

/*
#import </usr/include/objc/objc-class.h>

@interface NSObject (X)
@end

*/

@implementation NSObject (X)

// initializer/class factory methods/constructors/destructor

// todo: z: we need consistency. should consider renaming this to with:
+ (id) withHash: (id)hash {
  return [[[self alloc] initWithHash:hash] autorelease];
}

// todo: z: we need consistency. should consider renaming this to initWith:
- (id) initWithHash: (id)hash {
 	if (self = [self init]) {
		[self _setAttributes:hash];
	}
	return self;
}

// public class methods

// todo: z:
// add methods for adding a method but where you can choose the name e.g.
// + addInstanceMethod:@"sayHi" imp:hello]);
// + addMethod: (id)methodName imp: (imp)methodImpl
// - addMethod: (id)methodName imp: (imp)methodImpl

+ (BOOL) addInstanceMethod: (id)xMethod {
  return class_addMethod([self class], [xMethod selector], [xMethod imp], [xMethod methodTypes]);
}

+ (BOOL) addMethod: (id)xMethod {
  Class class = objc_getMetaClass([NSStringFromClass([self class]) asCString]);
  return class_addMethod(class, [xMethod selector], [xMethod imp], [xMethod methodTypes]);
}

+ (BOOL) alias: (id)method as: (id) aliasName {
  id methodBeingAliased = [self getMethod:method];
  SEL aliasSelector = NSSelectorFromString(aliasName);
  Method existingMethodWithAliasName = class_getClassMethod(self, aliasSelector); // will be null if aliasName doesn't exist; otherwise it will be the existing Method
  if (existingMethodWithAliasName) {
    return (method_setImplementation(existingMethodWithAliasName, [methodBeingAliased imp]) != NULL);
  }
  else { // new method so add it
    Class class = objc_getMetaClass([NSStringFromClass([self class]) asCString]); // class must be the metaclass
    return class_addMethod(class, aliasSelector, [methodBeingAliased imp], [methodBeingAliased methodTypes]);
  }
}

+ (BOOL) aliasInstanceMethod: (id)method as: (id) aliasName {
  id methodBeingAliased = [self getInstanceMethod:method];
  SEL aliasSelector = NSSelectorFromString(aliasName);
  Method existingMethodWithAliasName = class_getInstanceMethod(self, aliasSelector); // will be null if aliasName doesn't exist; otherwise it will be the existing Method
  if (existingMethodWithAliasName) {
    return (method_setImplementation(existingMethodWithAliasName, [methodBeingAliased imp]) != NULL);
  }
  else { // new method so add it
    return class_addMethod(self, aliasSelector, [methodBeingAliased imp], [methodBeingAliased methodTypes]);
  }
}

+ (id) getInstanceMethod: (id)methodName {
  SEL selector = NSSelectorFromString(methodName);
  Method method = class_getInstanceMethod(self, selector);
  return [XMethod with:method from:self];
}

+ (id) getMethod: (id)methodName {
  SEL selector = NSSelectorFromString(methodName);
  Method method = class_getClassMethod(self, selector);
  return [XMethod with:method from:self];
}

+ (id) ivarAccessors: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id array = [XArray with:firstItem vaList:argList];  
  va_end(argList);  
  return [self _ivarAccessors:array];
}

+ (id) ivarReaders: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id readableAttributes = [XArray with:firstItem vaList:argList];
  va_end(argList);   
  return [self _ivarReaders:readableAttributes];
}

+ (id) ivarWriters: (id)firstItem, ... {
  va_list argList; 
  va_start(argList, firstItem);
  id writableAttributes = [XArray with:firstItem vaList:argList];
  va_end(argList);   
  return [self _ivarWriters:writableAttributes];
}

+ (id) replaceMethodImplementation: (id)methodName with: (id)replacementXMethod {
  id oldXMethod = [self getMethod:methodName];
  method_setImplementation([oldXMethod method], [replacementXMethod imp]);
  return self;
}

// public instance methods

- (BOOL) addMethod: (id)xMethod {
  return class_addMethod([self class], [xMethod selector], [xMethod imp], [xMethod methodTypes]);
}

- (BOOL) addMethod: (id)methodName imp:(IMP)imp methodTypes: (const char*)methodTypes {
  return class_addMethod([self class], [methodName asSelector], imp, methodTypes);
}

- (BOOL) alias: (id)method as: (id) aliasName {
  id methodBeingAliased = [self getMethod:method];
  SEL aliasSelector = NSSelectorFromString(aliasName);
  Method existingMethodWithAliasName = class_getInstanceMethod([self class], aliasSelector); // will be null if aliasName doesn't exist; otherwise it will be the existing Method
  if (existingMethodWithAliasName) { // existing method so change it's imp
    return (method_setImplementation(existingMethodWithAliasName, [methodBeingAliased imp]) != NULL);
  }
  else { // new method so add it
    return class_addMethod([self class], aliasSelector, [methodBeingAliased imp], [methodBeingAliased methodTypes]);
  }
}

// todo: z: add a class-level method for this also so you can put all of a class's declarative code in initialize
- (id) forward: (id)methodName to:(id)object {
  if ([self _hasDelegations]) {
    [[self _delegations] setObject:object forKey:methodName];
  }
  else {
    NSLog(@"use of NSObject:forward:to: when _hasDelegations returns NO");
  }
  return self;
}

- (id) forwardTo: (id)object methods: (id)firstMethodName, ... {
  va_list argList; 
  va_start(argList, firstMethodName);
  id methodNames = [XArray with:firstMethodName vaList:argList];
  va_end(argList);
  
  if ([self _hasDelegations]) {
    int i = 1;
    for (id methodName in methodNames) {
      [[self _delegations] setObject:object forKey:methodName];
    }
  }
  else {  
    NSLog(@"use of NSObject:forwardTo:methods: when _hasDelegations returns NO");
  }
  return self;
}

// todo: z: need to handle forwardInvocation case when the method is implemented by self and self is the target, i.e. when it's called directly or methodSignatureForSelector is called directly
- (void) forwardInvocation: (NSInvocation*)invocation {
  SEL selector = [invocation selector];
  id method = NSStringFromSelector(selector);
  id delegate;
  if ([self _hasDelegations] && [[self _delegations] objectForKey:method] != nil) {
    delegate = [[self _delegations] objectForKey:method];
   [invocation invokeWithTarget:delegate];
  }
  else if ([self _hasDelegations] && (delegate = [self _findObjectThatRespondsTo:selector])) {
    [invocation invokeWithTarget:delegate];
  }
  else {
    [self doesNotRecognizeSelector:selector];
  }
}

// todo: z: add a class-level method for this also so you can put all of a class's declarative code in initialize
- (id) forwardTo: (id)object {
  if ([self _hasDelegations]) {
    [[self _delegates] addObject:object];
  }
  else {
    NSLog(@"improper use of NSObject:_forwardTo: when _hasDelegations returns NO");
  }
  return self;
}

- (id) getInstanceVariable: (id)name {
  const char* ivarName = [name asCString];
  Ivar ivar = class_getInstanceVariable([self class], ivarName);
  return object_getIvar(self, ivar);
}

- (id) getMethod: (id)methodName {
  SEL selector = NSSelectorFromString(methodName);
  Method method = class_getInstanceMethod([self class], selector);
  return [XMethod with:method from:self];
}

- (BOOL) instanceOf: (Class)class {
  return [self isKindOfClass:class];
}

- (BOOL) isa: (Class)class {
  return [[self class] isSubclassOfClass:class];
}

- (BOOL) isKindOf: (Class)class {
  return [self isa:class];
}

- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector {
  id sig = nil;
  id method = NSStringFromSelector(selector);
  id delegate = nil;
  if ([self respondsToSelector:selector]) {
   return [[self class] instanceMethodSignatureForSelector:selector];
 }
 else if ([self _hasDelegations] && [[self _delegations] objectForKey:method] != nil) {
    id delegate = [[self _delegations] objectForKey:method];
    id class = [delegate class];
   return [class instanceMethodSignatureForSelector:selector];
  }
  else if ([self _hasDelegations] && (delegate = [self _findObjectThatRespondsTo:selector])) {
    // todo: z: need to extract some methods here
    id class = [delegate class];
   return [class instanceMethodSignatureForSelector:selector];
  }
  return nil;
}

// todo: z: should remove these from fx core and put them somewhere else, like fx:iphone or fx:threads
- (id) performMethodOnNewThread: (id)methodName {
  id paramSet = [_XParameterSet withHash:XHashWith(@"methodToPerform", methodName, nil)];
  [NSThread detachNewThreadSelector:@selector(_performMethodOnNewThreadHelper:) toTarget:self withObject:paramSet];
  return self;
} 

- (id) performMethodOnNewThread: (id)methodName withCallbackNamed: (id)callback {
  [NSThread detachNewThreadSelector:@selector(_performMethodOnNewThreadHelper:) toTarget:self withObject:[_XParameterSet withHash:XHashWith(@"methodToPerform", methodName, @"callbackName", callback, nil)]];
  return self;
} 

- (id) performMethodOnNewThread: (id)methodName withObject: (id)object {
  object = (object) ? object : nullObject;
  [NSThread detachNewThreadSelector:@selector(_performMethodOnNewThreadHelper:) toTarget:self withObject:[_XParameterSet withHash:XHashWith(@"methodToPerform", methodName, @"param1", object, @"hasParam1", trueObject, nil)]];
  return self;
} 

- (id) performMethodOnNewThread: (id)methodName withObject: (id)object withCallbackNamed: (id)callback {
  object = (object) ? object : nullObject;
  [NSThread detachNewThreadSelector:@selector(_performMethodOnNewThreadHelper:) toTarget:self withObject:[_XParameterSet withHash:XHashWith(@"methodToPerform", methodName, @"param1", object, @"hasParam1", trueObject, @"callbackName", callback, nil)]];
  return self;
} 

- (id) replaceMethodImplementation: (id)methodName with: (id)replacementXMethod {
  id oldXMethod = [self getMethod:methodName];
  method_setImplementation([oldXMethod method], [replacementXMethod imp]);
  return self;
}

- (id) setInstanceVariable: (id)name to: (id)value {
  const char* ivarName = [name asCString];
  Ivar ivar = class_getInstanceVariable([self class], ivarName);
  if (ivar) {
    id oldValue = object_getIvar(self, ivar); 
    object_setIvar(self, ivar, value);
    if (oldValue != value) {
      [value retain];
      [oldValue release];
    }
    return self;
  }  
  return self;
}

// todo: z: should move this to the iphone code; not needed here
// - (id) setValue: (id)value forUndefinedKey: (id)key {
//   // NSLog(@"NSObject+X: not going to setValue %@ for key %@", value, key);
//   return self;
// }

// protected class methods

+ (id) _ivarAccessors: (id)accessors {
  [self _ivarReaders:accessors];
  [self _ivarWriters:accessors];
  return self;
}

+ (id) _ivarReaders: (id)readers {
  for (id item in readers) {
    [self aliasInstanceMethod:@"_getAttributeByCmd" as:item];
  }
  return self;
}

+ (id) _ivarWriters: (id)writers {
  for (id item in writers) {
    [self aliasInstanceMethod:@"_setAttributeByCmd:" as:[XString withFormat:@"set%@:", [item asPascalCase], nil]];
  }
  return self;  
}

// protected instance methods

- (id) _delegates {
  return nil;
}

- (id) _findObjectThatRespondsTo: (SEL)selector {
  for (id delegate in [self _delegates]) {
    if ([delegate respondsToSelector:selector]) {
      return delegate;
    }
  }
  return nil;
}

- (id) _getAttributeByCmd {
  char buffer[128] = "_";
  // todo: z: what about memory consequences?
  const char* ivarName = strcat(buffer, sel_getName(_cmd));

  Ivar ivar = class_getInstanceVariable([self class], ivarName);
  if (!ivar) {
    ivarName = sel_getName(_cmd);
    ivar = class_getInstanceVariable([self class], ivarName);
  }
  if (ivar) {
    return object_getIvar(self, ivar);
  }
  return nil;
}

// todo: z: consider killing in favor of a _delegations getter
- (BOOL) _hasDelegations {
  return NO;
}

- (id) _performMethodOnNewThreadHelper:(id)parameterSet {
  id autoreleasePool = [[NSAutoreleasePool alloc] init];
  id methodToPerform = [parameterSet methodToPerform];
  SEL selectorToPerform = [methodToPerform asSelector];
  id callbackMethodName = [parameterSet callbackName];
  id param1 = [parameterSet param1];
  id param2 = [parameterSet param2];
  id returnType = [[XMethod withName:methodToPerform from:self] returnType];
  id returnValue = nil;
  if ([parameterSet hasParam2]) {
    NSLog(@"z: not currently implemented");
  }
  else if ([parameterSet hasParam1]) {
    returnValue = [self performSelector:selectorToPerform withObject:param1];
  }
  else {
    returnValue = [self performSelector:selectorToPerform];
  }
  if ([returnType isEqual:@"v"]) {
    returnValue = nil;
  }
  if (callbackMethodName) {
    // todo: z: this always assumes that the callbackMethod takes an argument; that is prolly not a great idea; this and the params should probably be determined by the method signatures
    [self performSelectorOnMainThread:[callbackMethodName asSelector] withObject:returnValue waitUntilDone:NO];
  }
  [autoreleasePool release];
  return self;
}

- (id) _setAttributeByCmd: (id)value {
  char buffer[128] = "_";
  const char* selectorName = sel_getName(_cmd);
  int length = strlen(selectorName);
  // todo: z: what about memory consequences?
  strncpy(buffer+1, selectorName+3, length - 4);
  buffer[1] += 32;
  const char* ivarName = buffer;
  
  Ivar ivar = class_getInstanceVariable([self class], ivarName);
  if (!ivar) {
    ivar = class_getInstanceVariable([self class], ivarName+1);
  }
  if (ivar) {
    [object_getIvar(self, ivar) autorelease]; // release the old value
    object_setIvar(self, ivar, value);
    [object_getIvar(self, ivar) retain]; // retain new value
    return self;
  }
  return self;
}
  
- (id) _setAttributes: (id)attributes {
  [self setValuesForKeysWithDictionary:attributes];
  return self;
}

- (id) _delegations {
  NSLog(@"inside NSObject:_delegations which is not good. this method should be overridden in a subclass.");
  return nil;
}

@end

// __end__
