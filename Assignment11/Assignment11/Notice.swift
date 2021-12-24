import Foundation

class Notice {
    
    var nid : Int = 0
    var title : String = ""
    var description : String = ""
    
    init(nid:Int, title:String ,description:String)
    {
        self.nid = nid
        self.title = title
        self.description = description
    }
    
}
