// ****************************************
// Generated from .m file
// ****************************************

#import "XCore.h"

@interface XImage : XObject {
   id _data;
   id _path;
}
+ (void) initialize;
+ (id) with: (id)imageData;
+ (id) withBase64EncodedString: (id)string;
+ (id) withContentsOfUrl: (id)url;
+ (id) atFilePath: (id)path;
- (id) initWith: (id)imageData;
- (id) initWithFilePath: (id)path;
- (void) dealloc;
- (BOOL) isEqual: (id)other;
- (id) writeToFile: (id)filePath;
@end
