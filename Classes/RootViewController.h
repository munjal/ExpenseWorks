#import <UIKit/UIKit.h>
#import "ToolbarController.h"

@interface RootViewController : UITableViewController {
@private
	NSArray* _toolbarItems;
}

@property(nonatomic, retain) NSArray* toolbarItems;

- (id)initWithToolbarItems:(NSArray*)items;
- (IBAction) doStuff;
- (NSArray *)toolBarItemsByCount:(NSInteger) count;
@end
