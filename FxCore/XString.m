#import "XString.h"

/*
#import "NSString+X.h"
#import "NSMutableString+X.h"

@interface XString : NSMutableString {
  id _delegate;
}
@end
*/

// todo: z: add an XStringWithFormat() function

@implementation XString 

+ (id) empty {	
  return [[[XString alloc] init] autorelease];
}
	
// constructors/destructors

- (id) init {
  if (self = [super init]) {
    _delegate = [[NSMutableString stringWithCapacity:16] retain];
  }
  return self;
}

- (id) initWithBytes:(const void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding {
  if (self = [super init]) {
    _delegate = [[NSMutableString alloc] initWithBytes:bytes length:length encoding:encoding];
  }
  return self;  
}

- (id) initWithBytesNoCopy:(void *)bytes length:(NSUInteger)length encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)flag {
  if (self = [super init]) {
    _delegate = [[NSMutableString alloc] initWithBytesNoCopy:bytes length:length encoding:encoding freeWhenDone:flag];
  }
  return self;  
}

- (id) initWithCapacity: (unsigned int)capacity {
  if (self = [super init]) {
    _delegate = [[NSMutableString stringWithCapacity:capacity] retain];
  }
  return self;
}

- (id) initWithCharactersNoCopy: (unichar*)chars length: (unsigned int)length freeWhenDone: (BOOL)flag {
  if (self = [super init]) {
    _delegate = [[NSMutableString alloc] initWithCharactersNoCopy:chars length:length freeWhenDone:flag];
  }
  return self;     
}

- (id) initWithContentsOfFile: (id) path {
  return [self initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];  
}

- (id) initWithContentsOfFile: (NSString*)path encoding: (NSStringEncoding)enc error: (NSError**)error {
  if (self = [super init]) {
    _delegate = [[NSMutableString alloc] initWithContentsOfFile:path encoding:enc error:error];
  }
  return self;
}

- (id) initWithCString: (const char*)nullTerminatedCString encoding: (NSStringEncoding)encoding {
  if (self = [super init]) {
    _delegate = [[NSMutableString alloc] initWithCString:nullTerminatedCString encoding:encoding];
  }
  return self;
}

- (id) initWithFormat: (NSString*)format, ... {
  va_list argList; 
  va_start(argList, format);
  id str = [self initWithFormat:format arguments:argList];  
  va_end(argList); 
  return str;
}

- (id) initWithFormat: (NSString*)format arguments:(va_list)argList {
  if (self = [super init]) {
    _delegate = [[NSMutableString alloc] initWithFormat:format arguments:argList];
  }
  return self;    
}
 
- (void) dealloc { 
  [_delegate release];
	[super dealloc]; 
}
 
 // public instance methods
 
// z: we have our own implementation of append because NSMutableString's is suboptimal (see note there)
- (id) append: (id)string {
 [self appendString:string];
 return self;
}
 
// required methods to subclass NSMutableArray

- (unichar) characterAtIndex: (NSUInteger)index {
  return [_delegate characterAtIndex:index];
}

- (id) description {
  return [_delegate description];
}

- (NSUInteger) length {
  return [_delegate length];
}

- (void) replaceCharactersInRange: (NSRange)range withString:(NSString*)string {
  [_delegate replaceCharactersInRange:range withString:string];
}

- (NSUInteger) replaceOccurrencesOfString: (NSString*)target withString: (NSString*)replacement options: (NSStringCompareOptions)opts range: (NSRange)searchRange {
  return [_delegate replaceOccurrencesOfString:target withString:replacement options:opts range:searchRange];
}

- (void) setString: (NSString*)string {
  [_delegate setString:string];
}




@end