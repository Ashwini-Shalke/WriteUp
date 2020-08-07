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
        static let firstPageDescription = "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."
        
        static let secondPageImageName = "Page2"
        static let secondPageTitle = "Subscribe and get coupons on our daily events"
        static let secondPageDescription = "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."
        
        static let thirdPageImageName = "Page3"
        static let thirdPageTitle = "leaf_third"
        static let thirdPageDescription = "Need to add something"
                
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
        static let labelHeight = CGSize(width: 0, height: 32)
        static let textfieldHeight = CGSize(width: 0, height: 37)
        static let signOutButtonTitle = "Sign out"
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
    
    
    
    static let MainColor: UIColor = UIColor(red: 137/255, green: 70/255, blue: 157/255, alpha: 1.0)
    static let SecondaryColor: UIColor = UIColor(red: 240/255, green: 111/255, blue: 56/255, alpha: 1.0)
}


