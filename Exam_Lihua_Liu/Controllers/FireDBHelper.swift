//
//  FireDBHelper.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject {
    
    @Published var favoriteList = [String]()
    
    private let db: Firestore
    private static var shared: FireDBHelper?
    
    init(db: Firestore) {
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper {
        if(shared == nil) {
            shared = FireDBHelper(db: Firestore.firestore())
        }
        return shared!
    }
    
    func updateFavoriteList() {
        db
            .collection("FavoriteList")
            .document("DefaultUser")
            .setData([
                "networkIds": self.favoriteList
            ]) { error in
                if let err = error {
                    print("Unable to update the list \(err)")
                } else {
                    print("List updated successfully")
                }
            }
    }
    
    func getFavoriteList() {
        db
            .collection("FavoriteList")
            .document("DefaultUser")
            .getDocument() { document, error in
                if let error = error {
                    print("Unable to get document: \(error)")
                } else {
                    guard let document = document else {
                        print("Document does not exist")
                        return
                    }
                    self.favoriteList = document.data()?["networkIds"] as? [String] ?? []
                }
            }
    }
}
