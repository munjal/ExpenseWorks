// ****************************************
// Generated from .m file
// ****************************************

#import "XObject.h"
#import </usr/include/objc/objc-class.h>

@interface XMethod : XObject {
  Method _method;
  id _owningObject;
}
+ (id) with: (Method)method from: (id)owningObject;
+ (id) withName: (id)methodName from: (id)owningObject;
- (id) initWith: (Method)method from: (id)owningObject;
- (void) dealloc;
- (id) description;
- (IMP) imp;
- (Method) method;
- (id) methodName;
- (const char*) methodTypes;
- (id) owningObject;
- (id) returnType;
- (SEL) selector;
- (BOOL) isEqual: (id)other;
@end
