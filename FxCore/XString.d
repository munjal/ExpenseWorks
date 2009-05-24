inherits_from: NSMutableString
conforms_to:
framework:
availability:
declared_in: 
  - XString.h
task_group_order:     
overview:                      
methods_to_exclude:
  - dealloc
  - init
  - new  
show_protected_methods: false
  
methods:
- signature: "+ (id) empty"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  availability:
  description:
  task_group:

- signature: "- (id) init"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  availability:
  description:
  task_group:

- signature: "- (id) initWithBytes:(const void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    bytes:
    length:
    encoding: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)flag"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    bytes:
    length:
    encoding:
    flag: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithCapacity: (unsigned int)capacity"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    int: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithCharactersNoCopy: (unichar*)chars length: (unsigned int)length freeWhenDone: (BOOL)flag"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    chars:
    int:
    BOOL: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithContentsOfFile: (id) path"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    path: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithContentsOfFile: (NSString*)path encoding: (NSStringEncoding)enc error: (NSError**)error"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    path:
    enc:
    error: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithCString: (const char*)nullTerminatedCString encoding: (NSStringEncoding)encoding"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    nullTerminatedCString:
    encoding: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithFormat: (NSString*)format, ..."
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    format,: 
  availability:
  description:
  task_group:

- signature: "- (id) initWithFormat: (NSString*)format arguments:(va_list)argList"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    format:
    argList: 
  availability:
  description:
  task_group:

- signature: "- (void) dealloc"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  availability:
  description:
  task_group:

- signature: "- (id) append: (id)string"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    string: 
  availability:
  description:
  task_group:

- signature: "- (unichar) characterAtIndex: (NSUInteger)index"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    index: 
  availability:
  description:
  task_group:

- signature: "- (id) description"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  availability:
  description:
  task_group:

- signature: "- (NSUInteger) length"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  availability:
  description:
  task_group:

- signature: "- (void) replaceCharactersInRange: (NSRange)range withString:(NSString*)string"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    range:
    string: 
  availability:
  description:
  task_group:

- signature: "- (NSUInteger) replaceOccurrencesOfString: (NSString*)target withString: (NSString*)replacement options: (NSStringCompareOptions)opts range: (NSRange)searchRange"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    target:
    replacement:
    opts:
    searchRange: 
  availability:
  description:
  task_group:

- signature: "- (void) setString: (NSString*)string"
  see_also: 
  discussion:
  return_value:
  declared_in: XString.h 
  parameters:
    string: 
  availability:
  description:
  task_group:

  
    
