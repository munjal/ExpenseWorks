// ****************************************
// Generated from .m file
// ****************************************

#import "XCore.h"

@interface XFile : XObject {
  id _fileManager;
  id _path;
}
+ (BOOL) copyFrom: (id)fromPath to:(id)toPath;
+ (id) create: (id)path;
+ (id) currentPath;
+ (id) delete: (id)path;
+ (BOOL) exists: (id)path;
+ (id) newWith: (id)path;
+ (id) open: (id)path;
+ (id) read: (id)path;
+ (id) resourcesDirectory;
- (id) initWith: (id)path;
- (void) dealloc;
- (id) delete;
- (id) description;
- (BOOL) exists;
- (id) fileManager;
- (id) path;
- (id) read;
- (id) readData;
- (id) write: (id)stuff;
@end
