//
//  RomStore.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-21.
//

import Foundation

final class RomStore: ObservableObject {
    @Published var objects: [Object] = []
    
    init() {
        #if DEBUG
        createDevData()
        #endif
    }
    
    func createDevData() {
        objects = [
            Object(
                objectID: 1001,
                title: "Hamilton Steam Engine",
                creditLine: "Industrial Heritage Collection, 1890",
                objectURL: "https://www.hamilton.ca/things-do/hamilton-civic-museums/hamilton-museum-steam-technology-national-historic-site",
                isPublicDomain: true,
                primaryImageSmall: "https://www.hamilton.museum images"),
            Object(
                objectID: 1002,
                title: "Victorian Era Dress",
                creditLine: "Fashion & Textiles Collection, circa 1875",
                objectURL: "https://www.bing.com/ck/a?!&&p=a3c94fe5bf4a2756658b9aa773eb2c9791d64cc313b465b38260b9ce2babf140JmltdHM9MTc0MDI2ODgwMA&ptn=3&ver=2&hsh=4&fclid=0d1a797e-d278-6a27-01d3-6c23d3d26bcb&u=a1L3Nob3A_cT12aWN0b3JpYW4rZXJhK2RyZXNzJkZPUk09U0hPUFBBJm9yaWdpbklHVUlEPTczQzdDNDVBQjc2MTQ5QzQ4NTlFRjUzRDc3NzI4MUM4&ntb=1",
                isPublicDomain: true,
                primaryImageSmall: "https://www.odysseytraveller.com/articles/victorian-womens-fashion/"),
            Object(
                objectID: 1003,
                title: "Indigenous Wampum Belt",
                creditLine: "First Nations Collection, Pre-1800s",
                objectURL: "https://www.bing.com/ck/a?!&&p=7ba0ef0b95f319d6914eeb33f7150a613fb03d9b0c5077331e9594510ce4d641JmltdHM9MTc0MDI2ODgwMA&ptn=3&ver=2&hsh=4&fclid=0d1a797e-d278-6a27-01d3-6c23d3d26bcb&u=a1L3Nob3A_cT1pbmRpZ2Vub3VzK3dhbXB1bStiZWx0JkZPUk09U0hPUFBBJm9yaWdpbklHVUlEPUZBREZBNDQ1QTMxMDRCOUZCMTUwQ0FFN0Y2QUQ0QUQx&ntb=1",
                isPublicDomain: false,
                primaryImageSmall: "https://sl.bing.net/bMG5nDpBtRs"),
            Object(
                objectID: 1004,
                title: "Early Hamilton Street Map",
                creditLine: "City Archives Collection, 1850",
                objectURL: "https://www.bing.com/ck/a?!&&p=c68c18c61ed9bb1994117e2529a75f13d9c5a7b5b0c6abe3cef0e19e4fee8d55JmltdHM9MTc0MDI2ODgwMA&ptn=3&ver=2&hsh=4&fclid=0d1a797e-d278-6a27-01d3-6c23d3d26bcb&u=a1L2ltYWdlcy9zZWFyY2g_cT1lYXJseStoYW1pbHRvbitzdHJlZXQrbWFwJnFwdnQ9RWFybHkrSGFtaWx0b24rU3RyZWV0K01hcCZGT1JNPUlHUkU&ntb=1",
                isPublicDomain: true,
                primaryImageSmall: "https://sl.bing.net/fynzFfe9yk8"),
            Object(
                objectID: 1005,
                title: "Steel Workers Photograph Collection",
                creditLine: "Industrial History Collection, 1920-1940",
                objectURL: "https://www.bing.com/ck/a?!&&p=7ac5a5d52816d14b5a1892d11ad4913a1a5e5a03ad20ab50fb29bd826980156bJmltdHM9MTc0MDI2ODgwMA&ptn=3&ver=2&hsh=4&fclid=0d1a797e-d278-6a27-01d3-6c23d3d26bcb&u=a1L2ltYWdlcy9zZWFyY2g_cT1zdGVlbCt3b3JrZXJzK3Bob3RvZ3JhcGgrY29sbGVjdGlvbiZxcHZ0PVN0ZWVsK1dvcmtlcnMrUGhvdG9ncmFwaCtDb2xsZWN0aW9uJkZPUk09SUdSRQ&ntb=1",
                isPublicDomain: true,
                primaryImageSmall: "https://sl.bing.net/eV2Ut6AE0iq")
        ]
    }
    
    func loadJSONData() {
        guard let url = Bundle.main.url(forResource: "museum_data", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([String: [MuseumItem]].self, from: data),
              let items = decoded["results"] else {
            print("Error loading JSON data")
            return
        }
        
        objects = items.map { $0.toObject() }
    }
    
    func search(query: String) {
        guard !query.isEmpty else {
            createDevData() // Reset to original data if query is empty
            return
        }
        
        let filteredObjects = objects.filter { object in
            object.title.lowercased().contains(query.lowercased()) ||
            object.creditLine.lowercased().contains(query.lowercased())
        }
        objects = filteredObjects
    }
}
