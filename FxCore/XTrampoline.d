inherits_from: XObject
conforms_to:
framework:
availability:
declared_in: 
  - XTrampoline.h
task_group_order:     
overview:                      
methods_to_exclude:
  - dealloc
  - init
  - new  
show_protected_methods: false
  
methods:
- signature: "+ (id) new: (id)targetObject bounceBackMethod: (id)bounceBackMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  parameters:
    targetObject:
    bounceBackMethod: 
  availability:
  description:
  task_group:

- signature: "- (id) initWith: (id)targetObject bounceBackMethod: (id)bounceBackMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  parameters:
    targetObject:
    bounceBackMethod: 
  availability:
  description:
  task_group:

- signature: "- (void) dealloc"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  availability:
  description:
  task_group:

- signature: "- (id) bounceBackMethod"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  availability:
  description:
  task_group:

- signature: "- (void) forwardInvocation: (NSInvocation*)invocation"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  parameters:
    invocation: 
  availability:
  description:
  task_group:

- signature: "- (NSMethodSignature*) methodSignatureForSelector: (SEL)selector"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  parameters:
    selector: 
  availability:
  description:
  task_group:

- signature: "- (id) targetObject"
  see_also: 
  discussion:
  return_value:
  declared_in: XTrampoline.h 
  availability:
  description:
  task_group:

  
    
