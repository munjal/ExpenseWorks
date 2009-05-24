inherits_from: XObject
conforms_to:
framework:
availability:
declared_in: 
  - NSObject+X.h
task_group_order:     
overview:                      
methods_to_exclude:
  - dealloc
  - init
  - new  
show_protected_methods: false
  
methods:
- signature: "+ (id) with: (id)hash"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    hash: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithHash: (id)hash"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    hash: 
  availability:
  description:
  task_group:

- signature: "+ (BOOL) addInstanceMethod: (id)xMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    xMethod: 
  availability:
  description:
  task_group:

- signature: "+ (BOOL) addMethod: (id)xMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    xMethod: 
  availability:
  description:
  task_group:

- signature: "+ (BOOL) alias: (id)method as: (id) aliasName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    method:
    aliasName: 
  availability:
  description:
  task_group:

- signature: "+ (BOOL) aliasInstanceMethod: (id)method as: (id) aliasName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    method:
    aliasName: 
  availability:
  description:
  task_group:

- signature: "+ (id) getInstanceMethod: (id)methodName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName: 
  availability:
  description:
  task_group:

- signature: "+ (id) getMethod: (id)methodName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName: 
  availability:
  description:
  task_group:

- signature: "+ (id) replaceMethodImplementation: (id)methodName with: (id)replacementXMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    replacementXMethod: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) addMethod: (id)xMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    xMethod: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) addMethod: (id)methodName imp:(IMP)imp methodTypes: (const char*)methodTypes"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    imp:
    methodTypes: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) alias: (id)method as: (id) aliasName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    method:
    aliasName: 
  availability:
  description:
  task_group:

- signature: "- (void) forward: (id)methodName to:(id)object"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    object: 
  availability:
  description:
  task_group:

- signature: "- (void) forwardInvocation: (NSInvocation*)invocation"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    invocation: 
  availability:
  description:
  task_group:

- signature: "- (void) forwardTo: (id)object"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    object: 
  availability:
  description:
  task_group:

- signature: "- (id) getInstanceVariable: (id)name"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    name: 
  availability:
  description:
  task_group:

- signature: "- (id) getMethod: (id)methodName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) instanceOf: (Class)class"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    class: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) isa: (Class)class"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    class: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) kindOf: (Class)class"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    class: 
  availability:
  description:
  task_group:

- signature: "- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    selector: 
  availability:
  description:
  task_group:

- signature: "- (id) performMethodOnNewThread: (id)methodName"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName: 
  availability:
  description:
  task_group:

- signature: "- (id) performMethodOnNewThread: (id)methodName withCallback: (id)callback"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    callback: 
  availability:
  description:
  task_group:

- signature: "- (id) performMethodOnNewThread: (id)methodName withObject: (id)object"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    object: 
  availability:
  description:
  task_group:

- signature: "- (id) performMethodOnNewThread: (id)methodName withObject: (id)object withCallback: (id)callback"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    object:
    callback: 
  availability:
  description:
  task_group:

- signature: "- (id) replaceMethodImplementation: (id)methodName with: (id)replacementXMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    methodName:
    replacementXMethod: 
  availability:
  description:
  task_group:

- signature: "- (id) setInstanceVariable: (id)name to: (id)value"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    name:
    value: 
  availability:
  description:
  task_group:

- signature: "- (id) setValue: (id)value forUndefinedKey: (id)key"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    value:
    key: 
  availability:
  description:
  task_group:

- signature: "- (id) _delegates"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) _findObjectThatRespondsTo: (SEL)selector"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    selector: 
  availability:
  description:
  task_group:

- signature: "-(BOOL) _hasDelegations"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "-(id) _methodMissing: (id)method object:(id)object"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    method:
    object: 
  availability:
  description:
  task_group:

- signature: "- (id) _performMethodOnNewThreadHelper:(id)parameterSet"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    parameterSet: 
  availability:
  description:
  task_group:

- signature: "- (id) _setAttributes: (id)attributes"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    attributes: 
  availability:
  description:
  task_group:

- signature: "- (id) _setDelegations: (id)delegations"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  parameters:
    delegations: 
  availability:
  description:
  task_group:

- signature: "- (id) _specificDelegations"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "+ (void) initialize"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "- (BOOL) hasCallback"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "- (BOOL) hasParam1"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "- (BOOL) hasParam2"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

- signature: "- (void) dealloc"
  see_also: 
  discussion:
  return_value:
  declared_in: NSObject+X.h 
  availability:
  description:
  task_group:

  
    
