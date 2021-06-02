//
//  JETeacher.swift
//  JarvisEd_iOS
//
//  Created by Austin Alex on 5/10/21.
//  Copyright © 2021 Austin Alex. All rights reserved.
//

import Foundation

class JETeacher {
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mID:String
    private var mFullName:String
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    public init(id:String, fullName:String) {
        
        mID = id
        mFullName = fullName
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func getID() -> String {
        
        return mID
        
    }
    
    public func getFullName() -> String {
        
        return mFullName
        
    }
    
}
