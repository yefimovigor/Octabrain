//Class "OTMainViewController" - "Octabrain test" main view controller
//Created by Igor S Yefimov
//Copyright Igor S Yefimov


#import <UIKit/UIKit.h>




@interface OTMainViewController: UIViewController

//User interface
@property IBOutlet UIScrollView* scrollView;
@property IBOutletCollection(UITextView) NSArray* textFields;

@end