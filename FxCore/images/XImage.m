#import "XImage.h"
#import "XCore.h"
#import "XIo.h"

/*
#import "XCore.h"

@interface XImage : XObject {
   id _data;
   id _path;
}
@end
*/

@implementation XImage

+ (void) initialize {
  [self ivarReaders:@"data", @"path", nil];
}

+ (id) with: (id)imageData {
  return [[[self alloc] initWith:imageData] autorelease];
}

+ (id) withBase64EncodedString: (id)string {
  return [[self alloc] initWith:[string decodeBase64]];
}

+ (id) withContentsOfUrl: (id)url {
  return [self with:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]]];
}

+ (id) atFilePath: (id)path {
  return [[[self alloc] initWithFilePath:path] autorelease];
}

- (id) initWith: (id)imageData {
  if (self = [super init]) {
    _data = [imageData retain];
  }
  return self;
}

- (id) initWithFilePath: (id)path {
  id result = [self initWith:[NSData dataWithContentsOfFile:path]];
  _path = [path retain];
  return result;
}

- (void) dealloc {
  [_data release];
  [_path release];  
  [super dealloc];
}

// public instance methods

- (BOOL) isEqual: (id)other {
  if (isNilOrNull(other)) {
    return NO;
  }
  if (![other isa:[self class]]) {
    return NO;
  }
  return [_data isEqual:[other data]];
}

- (id) writeToFile: (id)filePath {
  id file = [XFile open:filePath];  
  [file write:_data];
  return self;
}
@end
