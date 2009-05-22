#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Currency : SQLitePersistentObject {
	NSString		*name;
	NSDate			*lastSelectedOn;
}

@property (nonatomic, retain) NSString		*name;
@property (nonatomic, retain) NSDate		*lastSelectedOn;

@end
