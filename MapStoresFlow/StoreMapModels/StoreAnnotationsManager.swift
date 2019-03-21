//
//  StoreAnnotationsManager.swift
//  Superheroes
//
//  Created by Tomas Mateo Perotti on 14/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import Foundation
import MapKit

class StoreAnnotationsManager {
    
    // MARK: deberia ser un singleton
    
    var storeAnnotationsList : [StoreComicAnnotation] = []
    
    static let shared = StoreAnnotationsManager()
    
    private init () {
        launch()
    }
    
    public func launch () -> [StoreComicAnnotation] {
        
        if storeAnnotationsList.isEmpty {
           
            storeAnnotationsList.append(StoreComicAnnotation(title: "Kurogane Fanstore", subtitle: "Comic Store", coordinate: CLLocationCoordinate2D(latitude: -40.741898, longitude: -73.989308)))
            storeAnnotationsList.append(StoreComicAnnotation(title: "Yoko Store", subtitle: "Comic Store", coordinate: CLLocationCoordinate2D(latitude: -38.7211738, longitude: -62.2589567)))
            
            storeAnnotationsList.append(StoreComicAnnotation(title: "Trilogy Games", subtitle: "Comic Store", coordinate: CLLocationCoordinate2D(latitude: -38.7143687, longitude: -62.2676689)))
            storeAnnotationsList.append(StoreComicAnnotation(title: "Tienda Arcoiris", subtitle: "Comic Store", coordinate: CLLocationCoordinate2D(latitude: -38.7182771, longitude: -62.261953)))
            storeAnnotationsList.append(StoreComicAnnotation(title: "Don Bosco", subtitle: "Comic Store", coordinate: CLLocationCoordinate2D(latitude: -38.7191509, longitude: -62.269599)))
            storeAnnotationsList.append(StoreComicAnnotation(title: "Don Quijote", subtitle: "Comic Store", coordinate: CLLocationCoordinate2D(latitude: -38.7222883, longitude: -62.2646183)))

        }
        
        return storeAnnotationsList
    }
    
}
