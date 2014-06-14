//
//  MATextFieldCell.swift
//
//  Created by Mike Amaral on 6/12/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

import UIKit

enum MATextFieldType: Int {
    case Default = 0, Name, Phone, Email, Address, StateAbbr, ZIP, Number, Decimal
}

enum MATextFieldActionType: Int {
    case None = 0, Next, Done
}

class MATextFieldCell: UITableViewCell, UITextFieldDelegate {
    let textField: UITextField = UITextField(frame: CGRectZero)
    let fieldVeriticalPadding: CGFloat = 7.0
    let fieldHorizontalPadding: CGFloat = 10.0
    let toolbarHeight: CGFloat = 50.0
    var actionBlock: (() -> ())?
    let type: MATextFieldType
    let action: MATextFieldActionType
    var shouldAttemptFormat: Bool = true

    init(type: MATextFieldType?, action: MATextFieldActionType?) {
        // if the optional type and action enums were provided, set them
        self.type = type ? type! : .Default
        self.action = action ? action! : .None
        
        super.init(style: .Default, reuseIdentifier: nil)
        
        // basic configuration and creation of text field to fit within the bounds of the
        // cell and handle rotation nicely
        self.selectionStyle = .None
        self.textField.delegate = self
        self.textField.frame = CGRectMake(fieldHorizontalPadding, fieldVeriticalPadding, CGRectGetWidth(self.contentView.frame) - 2 * fieldHorizontalPadding, CGRectGetHeight(self.contentView.frame) - (2 * fieldVeriticalPadding))
        self.textField.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.contentView.addSubview(self.textField)
        
        // configure the textfield based on the type and action
        configureTextField()
    }
    
    // MARK: - setup
    
    func configureTextField() {
        var requiresToolbar = false
        
        // based on the type of the field, we want to format the textfield according
        // to the most user-friendly conventions. Any of these values can be overridden
        // later if users want to customize further. Any of the fields with numeric keyboard
        // types require a toolbar to handle the next/done functionality
        switch (self.type) {
        case .Default:
            self.textField.autocapitalizationType = .Sentences
            self.textField.autocorrectionType = .Yes
            self.textField.keyboardType = .Default
        case .Name:
            self.textField.autocapitalizationType = .Words
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .Default
        case .Phone:
            self.textField.autocapitalizationType = .None
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .NumberPad
            self.textField.placeholder = "Phone"
            self.textField.addTarget(self, action: "formatPhoneNumber", forControlEvents: .EditingChanged)
            requiresToolbar = true
        case .Email:
            self.textField.autocapitalizationType = .None
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .EmailAddress
            self.textField.placeholder = "Email"
        case .Address:
            self.textField.autocapitalizationType = .Words
            self.textField.autocorrectionType = .Yes
            self.textField.keyboardType = .Default
        case .StateAbbr:
            self.textField.autocapitalizationType = .AllCharacters
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .Default
            self.textField.placeholder = "State"
        case .ZIP:
            self.textField.autocapitalizationType = .None
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .NumberPad
            self.textField.placeholder = "ZIP"
            requiresToolbar = true
        case .Number:
            self.textField.autocapitalizationType = .None
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .NumberPad
            requiresToolbar = true
        case .Decimal:
            self.textField.autocapitalizationType = .None
            self.textField.autocorrectionType = .No
            self.textField.keyboardType = .DecimalPad
            requiresToolbar = true
        }
        
        // if any of the fields require a toolbar, set up the toolbar with the appropriate title,
        // otherwise set the appropriate return key type on the keyboard
        switch (self.action) {
        case .None:
            self.textField.returnKeyType = .Default
        case .Next:
            if requiresToolbar {
               setupToolbarWithButtonTitle("Next")
            }
            else {
                self.textField.returnKeyType = .Next
            }
        case .Done:
            if requiresToolbar {
               setupToolbarWithButtonTitle("Done")
            }
            else {
                self.textField.returnKeyType = .Done
            }
        }
    }
    
    func setupToolbarWithButtonTitle(buttonTitle: String) {
        // create the toolbar and use a flexible space button to right-mount the action button, and point it towards the function
        // that will call the action block
        let toolBar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), toolbarHeight))
        let flexibleSpaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let actionButton: UIBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .Plain, target: self, action: "handleToolbarButtonPressed")
        toolBar.items = [flexibleSpaceButton, actionButton]
        self.textField.inputAccessoryView = toolBar
    }
    
    func handleToolbarButtonPressed() {
        self.actionBlock?()
    }
    
    
    // MARK: - text field delegate
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.actionBlock?()
        return false
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        switch (self.type) {
        // the state abbreviation cell should only allow two characeters
        case .StateAbbr:
            let resultString: String = textField.text.bridgeToObjectiveC().stringByReplacingCharactersInRange(range, withString:string)
            return countElements(resultString) < 3
            
        // the zip cell should only allow 5 characters - TODO: allow for hyphenated zips
        case .ZIP:
            let resultString: String = textField.text.bridgeToObjectiveC().stringByReplacingCharactersInRange(range, withString:string)
            return countElements(resultString) < 6
            
        // the phone cell should only allow up to 15 characters, and we want to flag that we should
        // attempt to format the phone number as long as they are adding characters... if they are
        // deleting characters ignore it and don't attempt to format - TODO: allow for prepended '1' and extentions
        case .Phone:
            let resultString: String = textField.text.bridgeToObjectiveC().stringByReplacingCharactersInRange(range, withString:string)
            let oldString: String = self.textField.text
            let oldCount = countElements(oldString)
            let newCount = countElements(resultString)
            shouldAttemptFormat = newCount > oldCount
            return newCount < 15
            
        // otherwise we should just let them continue
        default:
            return true
        }
    }
    
    
    // MARK: - phone number formatting
    
    func formatPhoneNumber() {
        // this value is determined when textField shouldChangeCharactersInRange is called on a phone
        // number cell - if a user is deleting characters we don't want to try to format it, otherwise
        // using the current logic below certain deletions will have no effect
        if !shouldAttemptFormat {
            return
        }
        
        // here we are leveraging some of the objective-c NSString functions to help parse and modify
        // the phone number... first we strip anything that's not a number from the textfield, and then
        // depending on the current value we append formatting characters to make it pretty
        let currentValue: NSString = self.textField.text
        let strippedValue: NSString = currentValue.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch, range: NSMakeRange(0, currentValue.length))
        var formattedString: NSString = ""
        if strippedValue.length == 0 {
            formattedString = "";
        }
        else if strippedValue.length < 3 {
            formattedString = "(" + strippedValue
        }
        else if strippedValue.length == 3 {
            formattedString = "(" + strippedValue + ") "
        }
        else if strippedValue.length < 6 {
            formattedString = "(" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringFromIndex(3)
        }
        else if strippedValue.length == 6 {
            formattedString = "(" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringFromIndex(3) + "-"
        }
        else if strippedValue.length <= 10 {
            formattedString = "(" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringWithRange(NSMakeRange(3, 3)) + "-" + strippedValue.substringFromIndex(6)
        }
        
        self.textField.text = formattedString
    }
    
}
