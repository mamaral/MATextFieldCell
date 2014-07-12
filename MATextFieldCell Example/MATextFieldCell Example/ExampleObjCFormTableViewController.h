//
//  ExampleObjCFormTableViewController.h
//  MATextFieldCell Example
//
//  Created by Mike on 7/12/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MATextFieldCell.h"

@interface ExampleObjCFormTableViewController : UITableViewController {
    NSArray *_sections;
    
    MATextFieldCell *_firstNameCell;
    MATextFieldCell *_lastNameCell;
    MATextFieldCell *_phoneCell;
    MATextFieldCell *_emailCell;
    MATextFieldCell *_websiteCell;
    MATextFieldCell *_passwordCell;
    
    MATextFieldCell *_streetCell;
    MATextFieldCell *_cityCell;
    MATextFieldCell *_stateCell;
    MATextFieldCell *_ZIPCell;
    
    MATextFieldCell *_nonEditableCell;
    MATextFieldCell *_optionalCell;
}

@end
