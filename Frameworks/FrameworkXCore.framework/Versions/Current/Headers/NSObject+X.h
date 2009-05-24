// ****************************************
// Generated from .m file
// ****************************************

#import </usr/include/objc/objc-class.h>

@interface NSObject (X)
+ (id) withHash: (id)hash;
- (id) initWithHash: (id)hash;
+ (BOOL) addInstanceMethod: (id)xMethod;
+ (BOOL) addMethod: (id)xMethod;
+ (BOOL) alias: (id)method as: (id) aliasName;
+ (BOOL) aliasInstanceMethod: (id)method as: (id) aliasName;
+ (id) getInstanceMethod: (id)methodName;
+ (id) getMethod: (id)methodName;
+ (id) ivarAccessors: (id)firstItem, ...;
+ (id) ivarReaders: (id)firstItem, ...;
+ (id) ivarWriters: (id)firstItem, ...;
+ (id) replaceMethodImplementation: (id)methodName with: (id)replacementXMethod;
- (BOOL) addMethod: (id)xMethod;
- (BOOL) addMethod: (id)methodName imp:(IMP)imp methodTypes: (const char*)methodTypes;
- (BOOL) alias: (id)method as: (id) aliasName;
- (id) forward: (id)methodName to:(id)object;
- (id) forwardTo: (id)object methods: (id)firstMethodName, ...;
- (void) forwardInvocation: (NSInvocation*)invocation;
- (id) forwardTo: (id)object;
- (id) getInstanceVariable: (id)name;
- (id) getMethod: (id)methodName;
- (BOOL) instanceOf: (Class)class;
- (BOOL) isa: (Class)class;
- (BOOL) isKindOf: (Class)class;
- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector;
- (id) performMethodOnNewThread: (id)methodName;
- (id) performMethodOnNewThread: (id)methodName withCallbackNamed: (id)callback;
- (id) performMethodOnNewThread: (id)methodName withObject: (id)object;
- (id) performMethodOnNewThread: (id)methodName withObject: (id)object withCallbackNamed: (id)callback;
- (id) replaceMethodImplementation: (id)methodName with: (id)replacementXMethod;
- (id) setInstanceVariable: (id)name to: (id)value;
+ (id) _ivarAccessors: (id)accessors;
+ (id) _ivarReaders: (id)readers;
+ (id) _ivarWriters: (id)writers;
- (id) _delegates;
- (id) _findObjectThatRespondsTo: (SEL)selector;
- (id) _getAttributeByCmd;
- (BOOL) _hasDelegations;
- (id) _performMethodOnNewThreadHelper:(id)parameterSet;
- (id) _setAttributeByCmd: (id)value;
- (id) _setAttributes: (id)attributes;
- (id) _delegations;
@end
