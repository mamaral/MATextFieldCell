//
//  ExampleObjCFormTableViewController.m
//  MATextFieldCell Example
//
//  Created by Mike on 7/12/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import "ExampleObjCFormTableViewController.h"

@interface ExampleObjCFormTableViewController ()

@end

@implementation ExampleObjCFormTableViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}


#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self generateCells];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_firstNameCell.textField becomeFirstResponder];
}

- (void)generateCells {
    _firstNameCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeName action:MATextFieldActionTypeNext actionHandler:^{
        [_lastNameCell.textField becomeFirstResponder];
    }];
    _firstNameCell.textField.placeholder = @"First name";
    
    _lastNameCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeName action:MATextFieldActionTypeNext actionHandler:^{
        [_phoneCell.textField becomeFirstResponder];
    }];
    _lastNameCell.textField.placeholder = @"Last name";
    
    _phoneCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypePhone action:MATextFieldActionTypeNext actionHandler:^{
        [_emailCell.textField becomeFirstResponder];
    }];
    _phoneCell.textField.placeholder = @"Phone";
    
    _emailCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeEmail action:MATextFieldActionTypeNext actionHandler:^{
        [_websiteCell.textField becomeFirstResponder];
    }];
    _emailCell.textField.placeholder = @"Email";
    
    _websiteCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeURL action:MATextFieldActionTypeNext actionHandler:^{
        [_passwordCell.textField becomeFirstResponder];
    }];
    _websiteCell.textField.placeholder = @"Website";
    
    _passwordCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypePassword action:MATextFieldActionTypeNext actionHandler:^{
        [_streetCell.textField becomeFirstResponder];
    }];
    _passwordCell.textField.placeholder = @"Password";
    
    _streetCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeAddress action:MATextFieldActionTypeNext actionHandler:^{
        [_cityCell.textField becomeFirstResponder];
    }];
    _streetCell.textField.placeholder = @"Address";
    
    _cityCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeAddress action:MATextFieldActionTypeNext actionHandler:^{
        [_stateCell.textField becomeFirstResponder];
    }];
    _cityCell.textField.placeholder = @"City";
    
    _stateCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeStateAbbr action:MATextFieldActionTypeNext actionHandler:^{
        [_ZIPCell.textField becomeFirstResponder];
    }];
    _stateCell.textField.placeholder = @"State";
    
    _ZIPCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeZIP action:MATextFieldActionTypeDone actionHandler:^{
        [_ZIPCell.textField resignFirstResponder];
    }];
    _ZIPCell.textField.placeholder = @"ZIP";
    
    _nonEditableCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeNonEditable action:MATextFieldActionTypeNone actionHandler:nil];
    _nonEditableCell.textField.placeholder = @"Non-editable content";
    
    _optionalCell = [[MATextFieldCell alloc] initWithFieldType:MATextFieldTypeDefault action:MATextFieldActionTypeNone actionHandler:nil];
    _optionalCell.textField.placeholder = @"Additional info (optional)";
    
    NSArray *firstSection = @[_firstNameCell, _lastNameCell, _phoneCell, _emailCell, _websiteCell, _passwordCell];
    NSArray *secondSection = @[_streetCell, _cityCell, _stateCell, _ZIPCell];
    NSArray *thirdSection = @[_nonEditableCell, _optionalCell];
    _sections = @[firstSection, secondSection, thirdSection];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *cells = _sections[section];
    return cells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *cells = _sections[indexPath.section];
    return cells[indexPath.row];
}

@end
