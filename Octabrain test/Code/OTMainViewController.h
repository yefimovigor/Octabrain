//Class "OTMainViewController" - "Octabrain test" main view controller
//Created by Igor S Yefimov
//Copyright Igor S Yefimov


#import <UIKit/UIKit.h>




@interface OTMainViewController: UIViewController <UIScrollViewDelegate, UITextViewDelegate>

//User interface

//IBOutlets
@property IBOutlet UIScrollView* scrollView;
@property IBOutletCollection(UITextView) NSArray* textViews;

//Toolbar
@property UIToolbar* keyboardToolbar;

@end