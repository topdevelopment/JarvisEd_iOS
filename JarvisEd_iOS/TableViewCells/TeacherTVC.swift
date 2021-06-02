//
//  TeacherTVC.swift
//  JarvisEd_iOS
//  TOP Development
//

import UIKit

class TeacherTVC: UITableViewCell {
    
    /*
     *
     * UIOutlet Connections
     *
     */
    
    @IBOutlet weak var oTeacherNameLabel: UILabel!
    
    
    
    /*
     *
     * Member Variables
     *
     */
    
    public static let mReuseIdentifier = "teacherCell"
    private var mCurrentIndex:Int = -1
    private var mInfoButtonProtocol:InfoButtonProtocol? = nil
    
    
    
    /*
     *
     * Class Methods
     *
     */

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    public func setInfoProtocol(infoProtocol:InfoButtonProtocol) {
        
        mInfoButtonProtocol = infoProtocol
        
    }
    
    public func setCurrentTeacher(teacher:JETeacher, index:Int) {
        
        oTeacherNameLabel.text = teacher.getFullName()
        mCurrentIndex = index
        
    }
    
    
    
    /*
     *
     * IBAction Methods
     *
     */
    
    @IBAction func aInfoButtonClicked(_ sender: UIButton) {
        
        if (mInfoButtonProtocol != nil) {
            
            mInfoButtonProtocol?.infoButtonClicked(index: mCurrentIndex)
            
        }
        
    }
    
}
