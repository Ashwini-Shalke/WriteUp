//
//  StringConstants.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

struct Constant {
    
    //MARK: Onboarding screen
    struct Pages {
        static let firstPageImageName = "Page1"
        static let firstPageTitle = "Join use today in our fun and games!"
        static let firstPageDescripation = "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."
        
        static let secondPageImageName = "Page2"
        static let secondPageTitle = "Subscribe and get coupons on our daily events"
        static let secondPageDescripation = "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."
        
        static let thirdPageImageName = "Page3"
        static let thirdPageTitle = "leaf_third"
        static let thirdPageDescripation = "Need to add something"
                
        static let nextButtonTitle = "NEXT"
        static let prevButtonTitle = "PREV"
        static let skipButtonTitle = "SKIP"
        static let doneButtonTitle = "DONE"
    }
    
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
        static let Labelheight = CGSize(width: 0, height: 32)
        static let TextFieldheight = CGSize(width: 0, height: 37)
        static let signoutButtonTitle = "Sign out"
        static let placeholderImageName = "placeholder_photo"
        static let nameLabel = "Name"
        static let emailLabel = "Email"
        static let phoneLabel = "Phone Number"
        static let noteLabel = "Total notes"
        static let noOfNotes = "0"
        static let navTitle = "Profile"
    }
    
    //MARK: NoteBar
    struct NoteBar {
        static let notesLabel = "Notes"
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
}


