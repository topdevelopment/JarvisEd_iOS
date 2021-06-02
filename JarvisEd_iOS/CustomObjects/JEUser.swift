//
//  JEUser.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

class JEUser {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mFullName:String
    private var mUserType:UserType
    private var mEmail:String
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    init(email:String, fullName:String, userType:UserType) {
        
        mEmail = email
        mFullName = fullName
        mUserType = userType
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getEmail() -> String {
        
        return mEmail
        
    }
    
    public func getFullName() -> String {
        
        return mFullName
        
    }
    
    public func getUserType() -> UserType {
        
        return mUserType
        
    }
    
}
