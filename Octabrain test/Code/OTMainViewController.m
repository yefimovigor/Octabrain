//Class "OTMainViewController" - "Octabrain test" main view controller
//Created by Igor S Yefimov
//Copyright Igor S Yefimov


#import "OTMainViewController.h"




@interface OTMainViewController ()
@end




@implementation OTMainViewController

#pragma mark - Variables

UITextView* editedTextView;
NSString* editedTextViewText;
CGPoint scrollViewContentOffset;




#pragma mark - Handlers

- (void) handleKeyboardDidHideNotification:(NSNotification*)notification {
}




- (void) handleKeyboardDidShowNotification:(NSNotification*)notification {
}




- (void)handleKeyboardToolbarCancelButtonPressing:(id)sender {
    [self resignKeyboard];
}




- (void)handleKeyboardToolbarDoneButtonPressing:(id)sender {
    editedTextViewText=editedTextView.text;
    [self resignKeyboard];
}




#pragma mark - Initialisers

- (void) initKeyboardToolbar {
    self.keyboardToolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];

    UIBarButtonItem* cancelButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(handleKeyboardToolbarCancelButtonPressing:)
                                   ];
    UIBarButtonItem* doneButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(handleKeyboardToolbarDoneButtonPressing:)
                                 ];
    UIBarButtonItem* flexibleSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:nil
                                                                                 action:nil
                                    ];

    [self.keyboardToolbar setItems:[[NSArray alloc] initWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
}




#pragma mark - Keyboard

- (void) resignKeyboard {
    for (UITextView* textView in self.textViews)
        if ([textView isFirstResponder]) [textView resignFirstResponder];
}




#pragma mark - Text view

- (void) changeHeightConstraintForEditedTextViewTo:(float)heightConstraintValue {
    //Searching index of edited text view
    int index=0;
    for (UITextView* textView in self.textViews) {
        if ([editedTextView isEqual:textView])break;
        index++;
    }

    //Changing
    NSLayoutConstraint* heightConstraint=[self.textViewsHeightConstraints objectAtIndex:index];
    [UIView animateWithDuration:0.5f
                     animations:^{
                         heightConstraint.constant=heightConstraintValue;
                         [self.scrollView layoutIfNeeded];
                     }
     ];
}




- (void) onTextViewEditMode {
    if (editedTextView) {
        editedTextViewText=editedTextView.text;

        float dy=editedTextView.frame.origin.y-[[UIApplication sharedApplication] statusBarFrame].size.height;
        [self.scrollView setContentOffset:(CGPoint){0,dy} animated:YES];

        [self changeHeightConstraintForEditedTextViewTo:150];

        [editedTextView scrollRangeToVisible:[editedTextView selectedRange]];
    }
}




- (void) offTextViewEditMode {
    editedTextView.text=editedTextViewText;

    [self.scrollView setContentOffset:(CGPoint){0,scrollViewContentOffset.y} animated:YES];

    [self changeHeightConstraintForEditedTextViewTo:editedTextView.contentSize.height];
}




#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView*)scrollView {
    scrollViewContentOffset=self.scrollView.contentOffset;
}




#pragma mark - UITextViewDelegate

- (BOOL) textViewShouldBeginEditing:(UITextView*)textView {
    editedTextView=textView;
    return YES;
}




- (BOOL) textViewShouldEndEditing:(UITextView*)textView {
    return YES;
}




- (void)textViewDidBeginEditing:(UITextView*)textView {
    [self onTextViewEditMode];
}




- (void)textViewDidEndEditing:(UITextView*)textView {
    [self offTextViewEditMode];
}




#pragma mark - UIViewController (view lifecycle)

- (void) viewDidLoad {
    [super viewDidLoad];


    //Properties initialization

    //Scroll view
    self.scrollView.delegate=self;

    //Toolbar
    [self initKeyboardToolbar];

    //Text views
    for (UITextView* textView in self.textViews) {
        textView.inputAccessoryView=self.keyboardToolbar;
        textView.delegate=self;
    }


    //Subscription to notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil
     ];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidShowNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil
     ];
}




- (void)viewDidAppear:(BOOL)animated {
}

@end