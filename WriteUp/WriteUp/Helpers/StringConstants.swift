//
//  StringConstants.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

struct Constant {
    //MARK: Home screen
    struct HomeSC {
        static let barLabel = "WriteUp"
    }
    
    //MARK: SignIn Screen
    struct  SignInSC {
        static let logoImageName = "AppLogo"
    }
    
    //MARK: ProfileLauncher Screen
    struct ProfileSC {
        static let labelHeight = CGSize(width: 0, height: 32)
        static let textfieldHeight = CGSize(width: 37, height: 32)
        static let signOutButtonTitle = "Sign out"
        static let placeholderImageName = "placeholder_photo"
        static let nameLabel = "Name"
        static let emailLabel = "Email"
        static let phoneLabel = "Phone Number"
        static let noteLabel = "Total notes"
        static let noOfNotes = "0"
        static let navTitle = "Profile"
        static let switchLabel = "Screen Lock"
    }
    
    //MARK: NoteBar
    struct NoteBar {
        static let notesLabel = "Activity"
        static let showAllButton = "Show All"
    }
    
    //MARK: HeaderNoteBar
    struct HeaderNoteBar {
        static let addNoteImage = "addNote"
        static let addNoteLabel =  "Add Note"
    }
    
    //MARK: AddNote Screen
    struct AddNote {
        static let barLabel = "Add Note"
        static let nextButtonTitle = "Next"
        static let titleLabel = "Title"
        static let titleTextFieldPlaceHolder = "Keep it short"
        static let summaryLabel = "Summary"
        static let summaryTextFieldPlaceHolder = "Add small description"
        static let chooseTagLabel = "Choose Tag"
    }
    
    struct ShowAllNote {
        static let barLabel = "Notes"
    }
    
    static let MainColor: UIColor = UIColor(red: 137/255, green: 70/255, blue: 157/255, alpha: 1.0)
    static let SecondaryColor: UIColor = UIColor(red: 240/255, green: 111/255, blue: 56/255, alpha: 1.0)
    static let initFatalError:String = "init(coder:) has not been implemented"
    
    enum contextName {
        case NewScreen
        case EditScreen
    }
    
    struct LocalAuth {
        static let localizedReason = "Unlock WriteUp"
        static let errorAttributedString = "WriteUp Locked"
        static let alertTitle = "Biometry unavailable"
        static let alertMessage = "Your device is not configured for biometric authentication."
    }
    
    struct tableCellId {
        static let cellId = "CellID"
        static let headerId = "HeaderID"
    }
}


