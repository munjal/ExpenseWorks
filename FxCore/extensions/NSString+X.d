inherits_from: 
conforms_to:
framework:
availability:
declared_in: 
  - NSString+X.h
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
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "+ (id) from: (id)value"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    value: 
  availability:
  description:
  task_group:

- signature: "+ (id) fromCString: (const char*)string"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    string: 
  availability:
  description:
  task_group:

- signature: "+ (id) fromContentsAtPath: (id)path"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    path: 
  availability:
  description:
  task_group:

- signature: "+ (id) fromData: (id)data"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    data: 
  availability:
  description:
  task_group:

- signature: "+ (id) fromSelector: (SEL)selector"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    selector: 
  availability:
  description:
  task_group:

- signature: "+ (id) with: (id)string, ..."
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    string,: 
  availability:
  description:
  task_group:

- signature: "+ (id) withBytes:(const void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    bytes:
    length:
    encoding: 
  availability:
  description:
  task_group:

- signature: "+ (id) withBytesNoCopy:(void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)flag"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    bytes:
    length:
    encoding:
    flag: 
  availability:
  description:
  task_group:

- signature: "+ (id) withFormat: (id) format, ..."
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    format,: 
  availability:
  description:
  task_group:

- signature: "+ (id) withFormat: (id) format arguments:(va_list)argList"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    format:
    argList: 
  availability:
  description:
  task_group:

- signature: "- (id) append: (id)str"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    str: 
  availability:
  description:
  task_group:

- signature: "- (BOOL) contains: (id)str"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    str: 
  availability:
  description:
  task_group:

- signature: "- (int) countOccurrences: (char)character"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    character: 
  availability:
  description:
  task_group:

- signature: "- (id) decodeBase64"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) decrypt"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) copyReplacing: (id)toMatch with:(id)replacement"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    toMatch:
    replacement: 
  availability:
  description:
  task_group:

- signature: "- (id) downcase"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (BOOL) endsWith: (id)string"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    string: 
  availability:
  description:
  task_group:

- signature: "- (id) encrypt"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) gsub: (id)regex with: (id)replacement"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    regex:
    replacement: 
  availability:
  description:
  task_group:

- signature: "- (id) gsub: (id)regex with: (id)replacement modifiers: (id)firstMatchNumber, ..."
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    regex:
    replacement:
    firstMatchNumber,: 
  availability:
  description:
  task_group:

- signature: "- (id) hyphensAtHumps"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) inspect"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (BOOL) isEmpty"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (BOOL) matches: (id)regex"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    regex: 
  availability:
  description:
  task_group:

- signature: "- (id) pluralize"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) singularize"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) split: (id)separator"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    separator: 
  availability:
  description:
  task_group:

- signature: "- (id) splitIntoLinesNoLongerThan: (int)lineLength"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    lineLength: 
  availability:
  description:
  task_group:

- signature: "- (id) stringValue"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) substring: (int)startIndex length: (int)length"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    startIndex:
    length: 
  availability:
  description:
  task_group:

- signature: "- (const char*) asCString"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) asCamelCase"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) toDoubleObject"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) toIntObject"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) toPascalCase"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) toRubyCase"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (SEL) toSelector"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) toXmlCase"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) trim"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) underscoresAtHumps"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) underscoresAtHyphens"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) urlEncode"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "- (id) withoutWhitespace"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

- signature: "+ (id) _with: (id)first vaList:(va_list)ap"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    first:
    ap: 
  availability:
  description:
  task_group:

- signature: "- (id) _gsub: (id)regex with: (id)replacement modifiers: (id)modifiersHash"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  parameters:
    regex:
    replacement:
    modifiersHash: 
  availability:
  description:
  task_group:

- signature: "- (id) _humpsAtUnderscoresAndHyphens"
  see_also: 
  discussion:
  return_value:
  declared_in: NSString+X.h 
  availability:
  description:
  task_group:

  
    
