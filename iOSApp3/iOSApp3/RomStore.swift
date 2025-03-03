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
                objectURL: "https://www.google.com/search?sca_esv=895a44c257e1c6a3&q=Hamilton+Steam+Engine&udm=2&fbs=ABzOT_CWdhQLP1FcmU5B0fn3xuWpA-dk4wpBWOGsoR7DG5zJBjLjqIC1CYKD9D-DQAQS3Z6EpsJ-_trBJaiPaUAUAuwPXV5T8Li3hAiIvloCzE4uy8EOaVTKIxzmKieNszY5lCZQL27CFnhqKKd6Gqm_ZjI4lBb5_r3Cyeb9u4GtX-shN7_gaZRbietnIJsJOd-2onB1AgIG1zqg3-bsieSUb8u0mF7iqQ&sa=X&ved=2ahUKEwiG9p6T--mLAxVoC3kGHeAPIvsQtKgLegQIFBAB&biw=1680&bih=962&dpr=2#vhid=LP1Ndf9HrpIxXM&vssid=mosaic:~:text=Search%20inside%20image-,Westfield%27s%20TH%26B%20Locomotive%20103%20%2D%20Hamilton%20Conservation%20Authority,-Visit",
                isPublicDomain: true,
                primaryImageSmall: "https://conservationhamilton.ca/blog/westfields-thb-locomotive-103/"),
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
                objectURL: "https://www.google.com/search?q=Early+Hamilton+Street+Map&sca_esv=895a44c257e1c6a3&udm=2&biw=1680&bih=962&ei=D5HDZ7-GDN-wptQPpcjPqQ4&ved=0ahUKEwj_ybjh_emLAxVfmIkEHSXkM-UQ4dUDCBE&uact=5&oq=Early+Hamilton+Street+Map&gs_lp=EgNpbWciGUVhcmx5IEhhbWlsdG9uIFN0cmVldCBNYXBIiRFQhQlYhQlwAXgAkAEAmAFJoAFJqgEBMbgBA8gBAPgBAfgBApgCAKACAKgCAJgDAJIHAKAHLQ&sclient=img#vhid=-tH_M7oKfF3CtM&vssid=mosaic:~:text=1875%20Rare%20Antique%20Map%20of%20Hamilton%2C%20Ontario%2C%20Canada%20%2D%20Vintage%20Hand%20Coloured%20Hamilton%20Street%20Map%20%2D%20LDN%20%2D%20Etsy%20Canada",
                isPublicDomain: true,
                primaryImageSmall: "https://www.etsy.com/ca/listing/1707997744/1875-rare-antique-map-of-hamilton"),
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
