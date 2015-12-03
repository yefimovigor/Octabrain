//Class "OTMainViewController" - "Octabrain test" main view controller
//Created by Igor S Yefimov
//Copyright Igor S Yefimov


#import "OTMainViewController.h"




@interface OTMainViewController ()
@end




@implementation OTMainViewController

#pragma mark - Handlers

- (void)handleKeyboardToolbarCancelButtonPressing:(id)sender {
    [self resignKeyboard];
}




- (void)handleKeyboardToolbarDoneButtonPressing:(id)sender {
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




#pragma mark - UIViewController (view lifecycle)

- (void) viewDidLoad {
    [super viewDidLoad];


    //Properties initialization

    //Toolbar
    [self initKeyboardToolbar];


    //Toolbar binding to the keyboard
    for (UITextView* textView in self.textViews)
        textView.inputAccessoryView=self.keyboardToolbar;
}




- (void)viewDidAppear:(BOOL)animated {
}

@end