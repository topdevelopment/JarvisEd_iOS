//
//  FirebaseComm.swift
//  JarvisEd_iOS
//  TOP Development
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseComm {
    
    /*
     *
     * Enum: FirebaseMethods
     *
     */
    
    public enum FirebaseMethod:String {
        
        case AttemptLogin, CreateNewUser, getUserInfo, GetAllStudents, GetAllTeachers, GetAllAdmins, GetAllReports, GetAllStudentReports, GetAllTeacherReports, AddStudent, AddTeacher, AddAdmin, AddReport, DeleteStudent, DeleteTeacher, DeleteAdmin
        
    }
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    private var mProtocol:FirebaseProtocol
    
    
    
    /*
     *
     * Field Variables
     *
     */
    
    private let USERS_COLLECTION_ID = "Users"
    private let STUDENTS_COLLECTION_ID = "Students"
    private let TEACHERS_COLLECTION_ID = "Teachers"
    private let ADMINS_COLLECTION_ID = "Admins"
    private let REPORTS_COLLECTION_ID = "Reports"
    
    private let FULLNAME_FIELD_ID = "fullName"
    private let USERTYPE_FIELD_ID = "userType"
    private let DATE_FIELD_ID = "date"
    private let REPORT_DETAILS_FIELD_ID = "reportDetails"
    private let REPORT_TYPE_FIELD_ID = "reportType"
    private let REPORTED_BY_FIELD_ID = "reportedBy"
    private let REPORTED_STUDENT_FIELD_ID = "student"
    
    
    
    /*
     *
     * Constructor
     *
     */
    
    public init(fProtocol:FirebaseProtocol) {
        
        mProtocol = fProtocol
        
    }
    
    
    
    /*
     *
     * Class Methods
     *
     */
    
    public func attemptLogin(email:String, password:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Auth.auth().signIn(withEmail: email, password: password, completion: {
                data, error in
                
                if let authError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.AttemptLogin)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.AttemptLogin)
                    
                }
                
            })
            
        }
        
    }
    
    public func createNewUser(email:String, password:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Auth.auth().createUser(withEmail: email, password: password) {
                authResult, error in
                
                if let authError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.CreateNewUser)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.CreateNewUser)
                    
                }
                
            }
            
        }
        
    }
    
    public func getUserInfo(email:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).getDocument(completion: {
                snapshot, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.getUserInfo)
                    
                } else {
                    
                    let fullName = snapshot?.data()?[self.FULLNAME_FIELD_ID] as! String
                    
                    var userType: UserType? = nil
                    if (snapshot?.data()?[self.USERTYPE_FIELD_ID] as! String == UserType.Student.rawValue) {
                        
                        userType = UserType.Student
                        
                    } else if (snapshot?.data()?[self.USERTYPE_FIELD_ID] as! String == UserType.StudentAdmin.rawValue) {
                        
                        userType = UserType.StudentAdmin
                        
                    } else if (snapshot?.data()?[self.USERTYPE_FIELD_ID] as! String == UserType.Teacher.rawValue) {
                        
                        userType = UserType.Teacher
                        
                    } else if (snapshot?.data()?[self.USERTYPE_FIELD_ID] as! String == UserType.TeacherAdmin.rawValue) {
                        
                        userType = UserType.TeacherAdmin
                        
                    } else if (snapshot?.data()?[self.USERTYPE_FIELD_ID] as! String == UserType.Admin.rawValue) {
                        
                        userType = UserType.Admin
                        
                    }
                    
                    if let type = userType {
                        
                        self.mProtocol.successObjResponse(method: FirebaseMethod.getUserInfo, obj: JEUser.init(email: snapshot!.documentID, fullName: fullName, userType: type))
                        
                    } else {
                        
                        self.mProtocol.errorResponse(method: FirebaseMethod.getUserInfo)
                        
                    }
                    
                }
                
            })
            
        }
        
    }
    
    public func getAllStudents(email:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).getDocuments(completion: {
                snapshots, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllStudents)
                    
                } else {
                    
                    if let documents = snapshots?.documents {
                        
                        for i in 0...documents.count-1 {
                            
                            let id = documents[i].documentID
                            let fullName = documents[i].data()[self.FULLNAME_FIELD_ID] as! String
                            self.mProtocol.successObjResponse(method: FirebaseMethod.GetAllStudents, obj: JEStudent.init(id: id, fullName: fullName))
                            
                        }
                        
                        self.mProtocol.successResponse(method: FirebaseMethod.GetAllStudents)
                        
                    }
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.GetAllStudents)
                    
                }
                
            })
            
        }
        
    }
    
    public func getAllTeachers(email:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.TEACHERS_COLLECTION_ID).getDocuments(completion: {
                snapshots, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllTeachers)
                    
                } else {
                    
                    if let documents = snapshots?.documents {
                        
                        for i in 0...documents.count-1 {
                            
                            let id = documents[i].documentID
                            let fullName = documents[i].data()[self.FULLNAME_FIELD_ID] as! String
                            self.mProtocol.successObjResponse(method: FirebaseMethod.GetAllTeachers, obj: JETeacher.init(id: id, fullName: fullName))
                            
                        }
                        
                        self.mProtocol.successResponse(method: FirebaseMethod.GetAllTeachers)
                        
                    }
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.GetAllTeachers)
                    
                }
                
            })
            
        }
        
    }
    
    public func getAllAdmins(email:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.ADMINS_COLLECTION_ID).getDocuments(completion: {
                snapshots, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllAdmins)
                    
                } else {
                    
                    if let documents = snapshots?.documents {
                        
                        for i in 0...documents.count-1 {
                            
                            let id = documents[i].documentID
                            let fullName = documents[i].data()[self.FULLNAME_FIELD_ID] as! String
                            self.mProtocol.successObjResponse(method: FirebaseMethod.GetAllAdmins, obj: JEAdmin.init(id: id, fullName: fullName))
                            
                        }
                        
                    }
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.GetAllAdmins)
                    
                }
                
            })
            
        }
        
    }
    
    public func getAllReports(email:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).getDocuments(completion: {
                snapshots, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllReports)
                    
                } else {
                    
                    if let documents = snapshots?.documents {
                        
                        for i in 0...(documents.count-1 ?? 0) {
                            
                            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).document(documents[i].documentID).collection(self.REPORTS_COLLECTION_ID).getDocuments(completion: {
                                snapshots, error in
                                
                                if let storeError = error {
                                    
                                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllReports)
                                    
                                } else {
                                    
                                    if let documents = snapshots?.documents {
                                        
                                        if (documents.count > 0) {
                                            
                                            for i in 0...documents.count-1 {
                                                
                                                let id = documents[i].documentID
                                                let data = documents[i].data()
                                                let date = data[self.DATE_FIELD_ID] as! String
                                                let reportDetails = data[self.REPORT_DETAILS_FIELD_ID] as! String
                                                let type = data[self.REPORT_TYPE_FIELD_ID] as! String
                                                let reportedBy = data[self.REPORTED_BY_FIELD_ID] as! String
                                                let reportedStudent = data[self.REPORTED_STUDENT_FIELD_ID] as! String
                                                
                                                print("type: " + type)
                                                var reportType:ReportType? = nil
                                                if (type == ReportType.ATTENDENCE.rawValue) {
                                                    reportType = ReportType.ATTENDENCE
                                                } else if (type == ReportType.CONFLICT.rawValue) {
                                                    reportType = ReportType.CONFLICT
                                                } else if (type == ReportType.EXPELLED.rawValue) {
                                                    reportType = ReportType.EXPELLED
                                                } else if (type == ReportType.SECLUDED.rawValue) {
                                                    reportType = ReportType.SECLUDED
                                                } else if (type == ReportType.SIP.rawValue) {
                                                    reportType = ReportType.SIP
                                                } else if (type == ReportType.MOOD.rawValue) {
                                                    reportType = ReportType.MOOD
                                                } else if (type == ReportType.BEHAVIOR.rawValue) {
                                                    reportType = ReportType.BEHAVIOR
                                                }
                                                
                                                self.mProtocol.successObjResponse(method: FirebaseMethod.GetAllReports, obj: JEReport.init(id: id, date: date, reportDetails: reportDetails, reportType: reportType!, reportedBy: reportedBy, reportedStudent: reportedStudent))
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                            })
                        }
                    }
                }
            })
        }
    }
    
    public func getStudentReports(email:String, student:JEStudent) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).document(student.getID()).collection(self.REPORTS_COLLECTION_ID).getDocuments(completion: {
                snapshots, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllStudentReports)
                    
                } else {
                    
                    if let documents = snapshots?.documents {
                        
                        for i in 0...documents.count-1 {
                            
                            let id = documents[i].documentID
                            let data = documents[i].data()
                            let date = data[self.DATE_FIELD_ID] as! String
                            let reportDetails = data[self.REPORT_DETAILS_FIELD_ID] as! String
                            let type = data[self.REPORT_DETAILS_FIELD_ID] as! String
                            let reportedBy = data[self.REPORTED_BY_FIELD_ID] as! String
                            let reportedStudent = data[self.REPORTED_STUDENT_FIELD_ID] as! String
                            
                            var reportType:ReportType? = nil
                            if (type == ReportType.ATTENDENCE.rawValue) {
                                reportType = ReportType.ATTENDENCE
                            } else if (type == ReportType.CONFLICT.rawValue) {
                                reportType = ReportType.CONFLICT
                            } else if (type == ReportType.EXPELLED.rawValue) {
                                reportType = ReportType.EXPELLED
                            } else if (type == ReportType.SECLUDED.rawValue) {
                                reportType = ReportType.SECLUDED
                            } else if (type == ReportType.SIP.rawValue) {
                                reportType = ReportType.SIP
                            }
                            
                            self.mProtocol.successObjResponse(method: FirebaseMethod.GetAllStudentReports, obj: JEReport.init(id: id, date: date, reportDetails: reportDetails, reportType: reportType!, reportedBy: reportedBy, reportedStudent: reportedStudent))
                            
                        }
                        
                    }
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.GetAllStudentReports)
                    
                }
                
            })
            
        }
        
    }
    
    public func getTeacherReports(email:String, teacher:JETeacher) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.TEACHERS_COLLECTION_ID).document(teacher.getID()).collection(self.REPORTS_COLLECTION_ID).getDocuments(completion: {
                snapshots, error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.GetAllTeacherReports)
                    
                } else {
                    
                    if let documents = snapshots?.documents {
                        
                        for i in 0...documents.count-1 {
                            
                            let id = documents[i].documentID
                            let data = documents[i].data()
                            let date = data[self.DATE_FIELD_ID] as! String
                            let reportDetails = data[self.REPORT_DETAILS_FIELD_ID] as! String
                            let type = data[self.REPORT_DETAILS_FIELD_ID] as! String
                            let reportedBy = data[self.REPORTED_BY_FIELD_ID] as! String
                            let reportedStudent = data[self.REPORTED_STUDENT_FIELD_ID] as! String
                            
                            var reportType:ReportType? = nil
                            if (type == ReportType.ATTENDENCE.rawValue) {
                                reportType = ReportType.ATTENDENCE
                            } else if (type == ReportType.CONFLICT.rawValue) {
                                reportType = ReportType.CONFLICT
                            } else if (type == ReportType.EXPELLED.rawValue) {
                                reportType = ReportType.EXPELLED
                            } else if (type == ReportType.SECLUDED.rawValue) {
                                reportType = ReportType.SECLUDED
                            } else if (type == ReportType.SIP.rawValue) {
                                reportType = ReportType.SIP
                            }
                            
                            self.mProtocol.successObjResponse(method: FirebaseMethod.GetAllTeacherReports, obj: JEReport.init(id: id, date: date, reportDetails: reportDetails, reportType: reportType!, reportedBy: reportedBy, reportedStudent: reportedStudent))
                            
                        }
                        
                    }
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.GetAllTeacherReports)
                    
                }
                
            })
            
        }
        
    }
    
    public func addStudent(email:String, fullName:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let data: [String:Any] = [
                self.FULLNAME_FIELD_ID:fullName
            ]
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).addDocument(data: data).addSnapshotListener({
                snapshot,error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.AddStudent)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.AddStudent)
                    
                }
                
            })
            
        }
        
    }
    
    public func deleteStudent(email:String, student:JEStudent) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).document(student.getID()).delete(completion: {
                error in
                
                if (error == nil) {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.DeleteStudent)
                    
                } else {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.DeleteStudent)
                    
                }
                
            })
            
        }
        
    }
    
    public func addTeacher(email:String, fullName:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let data: [String:Any] = [
                self.FULLNAME_FIELD_ID:fullName
            ]
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.TEACHERS_COLLECTION_ID).addDocument(data: data).addSnapshotListener({
                snapshot,error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.AddTeacher)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.AddTeacher)
                    
                }
                
            })
            
        }
        
    }
    
    public func deleteTeacher(email:String, teacher:JETeacher) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.TEACHERS_COLLECTION_ID).document(teacher.getID()).delete(completion: {
                error in
                
                if (error == nil) {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.DeleteTeacher)
                    
                } else {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.DeleteTeacher)
                    
                }
                
            })
            
        }
        
    }
    
    public func addAdmin(email:String, fullName:String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let data: [String:Any] = [
                self.FULLNAME_FIELD_ID:fullName
            ]
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.ADMINS_COLLECTION_ID).addDocument(data: data).addSnapshotListener({
                snapshot,error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.AddAdmin)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.AddAdmin)
                    
                }
                
            })
            
        }
        
    }
    
    public func deleteAdmin(email:String, admin:JEAdmin) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.ADMINS_COLLECTION_ID).document(admin.getID()).delete(completion: {
                error in
                
                if (error == nil) {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.DeleteAdmin)
                    
                } else {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.DeleteAdmin)
                    
                }
                
            })
            
        }
        
    }
    
    public func addReport(email:String, date:String, reportDetails:String, reportType:ReportType, student:JEStudent, teacher:JETeacher) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let data: [String:Any] = [
                self.DATE_FIELD_ID:date,
                self.REPORT_DETAILS_FIELD_ID: reportDetails,
                self.REPORT_TYPE_FIELD_ID: reportType.rawValue,
                self.REPORTED_BY_FIELD_ID: student.getFullName(),
                self.REPORTED_STUDENT_FIELD_ID: teacher.getFullName()
            ]
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.STUDENTS_COLLECTION_ID).document(student.getID()).collection(self.REPORTS_COLLECTION_ID).addDocument(data: data).addSnapshotListener({
                snapshot,error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.AddReport)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.AddReport)
                    
                }
                
            })
            
            Firestore.firestore().collection(self.USERS_COLLECTION_ID).document(email).collection(self.TEACHERS_COLLECTION_ID).document(teacher.getID()).collection(self.REPORTS_COLLECTION_ID).addDocument(data: data).addSnapshotListener({
                snapshot,error in
                
                if let storeError = error {
                    
                    self.mProtocol.errorResponse(method: FirebaseMethod.AddReport)
                    
                } else {
                    
                    self.mProtocol.successResponse(method: FirebaseMethod.AddReport)
                    
                }
                
            })
            
        }
        
    }
    
}
