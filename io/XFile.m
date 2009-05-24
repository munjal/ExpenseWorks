#import "XFile.h"
#import "XCore.h"
#import </usr/include/sys/stat.h>

/*
#import "XCore.h"

@interface XFile : XObject {
  id _fileManager;
  id _path;
}
@end
*/

@implementation XFile

+ (BOOL) copyFrom: (id)fromPath to:(id)toPath {
  id fileManager = [NSFileManager defaultManager];  
  id error = nil;  
  if ([fileManager fileExistsAtPath:toPath]) {
    BOOL removalSuccessful = [fileManager removeItemAtPath:toPath error:&error];
    if (!removalSuccessful) {
      NSLog(@"There was an error removing the file: %@", toPath);
      if (error) {
        NSLog(@"The error was: %@", error);        
      }
    }
  }
  BOOL copySuccessful = [fileManager copyItemAtPath:fromPath toPath:toPath error:&error];  
  if (!copySuccessful) {
    @throw [NSException with:[XString withFormat:@"An error occurred while moving %@ to %@: %@", fromPath, toPath, error, nil]];
  }
  return copySuccessful;
}

+ (id) create: (id)path {
  id file = [XFile newWith:path];
  if ([file exists]) {
    return file;
  }
  if ([[file fileManager] createFileAtPath:path contents:nil attributes:nil]) {
    return file;
  }
  return nil;
}

+ (id) currentPath {
  return [[NSFileManager defaultManager] currentDirectoryPath];
}

+ (id) delete: (id)path {
  return [[self open:path] delete];
}

+ (BOOL) exists: (id)path {
  return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (id) newWith: (id)path {
  return [[[XFile alloc] initWith:path] autorelease];
}

+ (id) open: (id)path {
  id file = [XFile newWith:path];;
  if ([file exists]) {
    return file;
  }
  else {
    if ([XFile create:path]) {
      return file;
    }
  }
  return nil;
} 

+ (id) read: (id)path {
  return [XString fromContentsAtPath:path];
}
  
+ (id) resourcesDirectory {
  return [[NSBundle mainBundle] resourcePath];
}
    
- (id) initWith: (id)path {
  if (self = [super init]) {
    _path = [path retain];
  }
  return self;
}

- (void) dealloc {
  if (_path) {
    [_path release];
  }
  if (_fileManager) {
    [_fileManager release];
  }
  [super dealloc];
}

// public methods

- (id) delete {
  NSError* error;
  if ([[self fileManager] removeItemAtPath:_path error:&error]) {
    return self;
  }
  else {
    NSLog(@"failed to delete file at %@. error = %@", _path, error);
    @throw error;
  }  
}

- (id) description {
  return _path;
}

- (BOOL) exists {
  return [[self fileManager] fileExistsAtPath:_path];
}

- (id) fileManager {
  if (!_fileManager) {
    _fileManager = [[NSFileManager defaultManager] retain];
  }
  return _fileManager;
}
  
- (id) path {
  return _path;
}

- (id) read {
  return [XString fromContentsAtPath:_path];
}

- (id) readData {
  return [NSData dataWithContentsOfFile:_path];  
}

- (id) write: (id)stuff {
  if ([stuff isKindOf:[NSString class]]) {
    NSError* error;
    if (![stuff writeToFile:_path atomically:YES encoding:NSUTF8StringEncoding  error:&error]) {
      NSLog(@"writing string %@ to %@ failed with error %@", stuff, _path, error);
    }
  }
  else if ([stuff isKindOf:[NSDictionary class]]) {
    if (![stuff writeToFile:_path atomically:YES]) {
      NSLog(@"writing dictionary %@ to %@ failed", stuff, _path);
    }
  }
  else if ([stuff isKindOf:[NSData class]]) {
    if (![stuff writeToFile:_path atomically:YES]) {
      NSLog(@"writing data %@ to %@ failed", stuff, _path);
    }    
  }
  else {
    NSLog(@"don't know how to handle writing %@ with class %@", stuff, [stuff class]);
    return nil;
  }
  return stuff;
}
  
@end
