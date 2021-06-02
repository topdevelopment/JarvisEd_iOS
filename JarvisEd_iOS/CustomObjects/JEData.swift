//
//  JEData.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation

class JEData {
    
    /*
     *
     * Member Variables
     *
     */
    
    public static let global:JEData = JEData.init()
    private var mCurrentUser:JEUser?
    private var mStudentList:[JEStudent]
    private var mTeacherList:[JETeacher]
    private var mAdminList:[JEAdmin]
    private var mReportList:[JEReport]
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    private init() {
        
        mStudentList = []
        mTeacherList = []
        mAdminList = []
        mReportList = []
        mCurrentUser = nil
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func addStudentToList(student:JEStudent) {
        
        mStudentList.append(student)
        
    }
    
    public func getStudentList() -> [JEStudent] {
        
        return mStudentList
        
    }
    
    public func addTeacherToList(teacher:JETeacher) {
        
        return mTeacherList.append(teacher)
        
    }
    
    public func getTeacherList() -> [JETeacher] {
        
        return mTeacherList
        
    }
    
    public func addAdminToList(admin:JEAdmin) {
        
        mAdminList.append(admin)
        
    }
    
    public func getAdminList() -> [JEAdmin] {
        
        return mAdminList
        
    }
    
    public func addReportToList(report:JEReport) {
        
        mReportList.append(report)
        
    }
    
    public func getReportList() -> [JEReport] {
        
        return mReportList
        
    }
    
    public func setCurrentUser(user:JEUser) {
        
        mCurrentUser = user
        
    }
    
    public func getCurrentUser() -> JEUser? {
        
        return mCurrentUser
        
    }
    
}
