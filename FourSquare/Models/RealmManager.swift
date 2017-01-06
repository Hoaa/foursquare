//
//  RealmManager.swift
//  FourSquare
//
//  Created by Duy Linh on 1/1/17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let sharedInstance = RealmManager()
    
    func getVenue(id: String, section: String) -> Venue? {
        var result: Venue?
        do {
            let realm = try Realm()
            result = realm.objects(Venue.self).filter("id = '\(id)' AND section = '\(section)'").first
        } catch let error{
            print(error)
        }
        return result
    }
    
    func getFavoriteVenues() -> Results<Venue> {
        var result: Results<Venue>!
        do {
            let realm = try Realm()
            result = realm.objects(Venue.self).filter("isFavorite = true").sorted(byProperty: "favoriteTimestamp", ascending: false)
        } catch let error {
            print(error)
        }
        return result
    }
    
    func getHistoryVenues() -> Results<Venue> {
        var result: Results<Venue>!
        do {
            let realm = try Realm()
            result = realm.objects(Venue.self).filter("isHistory = true").sorted(byProperty: "historyTimestamp", ascending: false)
        } catch let error {
            print(error)
        }
        return result
    }
    
    func getSaveVenues() -> Results<Venue> {
        var result: Results<Venue>!
        do {
            let realm = try Realm()
            result = realm.objects(Venue.self).filter("isSave = true").sorted(byProperty: "saveTimestamp", ascending: false)
        } catch let error {
            print(error)
        }
        return result
    }
    
    func addVenue(venue: Venue) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(venue)
            }
        } catch let error {
            print(error)
        }
    }
    
//    func updateVenueWithPhotos(id: String, section: String, photos: RealmSwift.List<Photo>) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                let venue = realm.objects(Venue.self).filter("id = '\(id)' AND section = '\(section)'").first
//                venue?.photos.removeAll()
//                venue?.photos.append(objectsIn: photos)
//                
//            }
//        } catch let error {
//            print(error)
//        }
//    }
    
    func addFavorite(venue: Venue) {
        do {
            let realm = try Realm()
            try realm.write {
                let venuesWillFavorite = realm.objects(Venue.self).filter("id = '\(venue.id)'")
                for element in venuesWillFavorite {
                    element.didFavorite = true
                }
                if let venueDidFavorite = realm.objects(Venue.self).filter("id = '\(venue.id)' AND isFavorite = true").first {
                    venueDidFavorite.favoriteTimestamp = Date()
                    return
                }
                if let venue = realm.objects(Venue.self).filter("id = '\(venue.id)' AND section = '\(venue.section)'").first {
                    venue.isFavorite = true
                    venue.favoriteTimestamp = Date()
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteFavorite(id: String) {
        do {
            let realm = try Realm()
            try realm.write {
                let venues = realm.objects(Venue.self).filter("id = '\(id)'")
                for element in venues {
                    element.didFavorite = false
                }
                if let venue = realm.objects(Venue.self).filter("id = '\(id)' AND isFavorite = true").first {
                    venue.isFavorite = false
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    func getVenueDetail(id: String) -> Venue? {
        var venue: Venue?
        do {
            let realm = try Realm()
            venue = realm.objects(Venue.self).filter("id = '\(id)'").first
        } catch let error {
            print(error)
        }
        return venue
    }
    
    func updateVenueDetail(venue: Venue){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(venue, update: true)
                realm.delete(venue.tips)
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateVenueWithTips(venueID: String, tips: [VenueTip]) {
        do {
            let realm = try Realm()
            let venue = realm.objects(Venue.self).filter("id = '\(venueID)'").first
            try realm.write {
                venue!.tips.append(contentsOf: tips)
                realm.add(venue!, update: true)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteAllVenuePhotos(venueID: String) {
        do {
            let realm = try Realm()
            guard let venue = realm.objects(Venue.self).filter("id = '\(venueID)'").first else { return }
            try realm.write {
                realm.delete(venue.photos)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteAllVenueTips(venueID: String) {
        do {
            let realm = try Realm()
            guard let venue = realm.objects(Venue.self).filter("id = '\(venueID)'").first else { return }
            try realm.write {
                realm.delete(venue.tips)
            }
        } catch let error {
            print(error)
        }
    }
}
