//
//  CommentViewModel.swift
//  MVVM-Example
//
//  Created by Serkan Mehmet Malagiç on 4.11.2021.
//

import Foundation
import UIKit

class CommentViewModel {
    
    var comments : [Comment]? = []
    
    
    func loadComments(vc : UIViewController, completion:  () -> () ) {
        NetworkClient.performRequest(vc: vc, object: [Comment].self, router: APIRouter.getPostsComments(id: "1")) { result in
            
            self.comments = result
                        
        } failure: { error in
            print(error.localizedDescription)
        }
        
        completion()
    }
    
    func numberOfRowsInSectionCount () -> Int{
        return comments?.count ?? 0
    }
    
    
}
