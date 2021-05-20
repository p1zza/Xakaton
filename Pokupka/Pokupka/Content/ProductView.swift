//
//  ProductView.swift
//  Pokupka
//
//  Created by Никита Скобелкин on 18.05.2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct ProductsListView: View {
    @EnvironmentObject var cart: CartData
    @State var title: String
    @State var locations: [String]
    @State var shops = [Shops]()
    @State private var region = MKCoordinateRegion()
    @State var isFull = true
    @State var sort = TypeSort.byPrice
    @State var changeSort = false
    @State var showAlert = false
    
    enum TypeSort {
        case byPrice
        case byDistance
    }
    
    private func randomShops () {
        let coordinates = [
            CLLocationCoordinate2D(latitude: 55.6902493, longitude: 37.5228572),
            CLLocationCoordinate2D(latitude: 55.6838007, longitude: 37.5234877)
        ]
        region.center = coordinates[0]
        region.span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        for (index, item) in locations.enumerated() {
            shops.append(Shops(location: item, price: Int.random(in: 40...60), km: Double.random(in: 0.5...5.0), coordinates: coordinates[index]))
        }
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: shops) { item in
                MapMarker(
                    coordinate: item.coordinates,
                    tint: Color("Colar")
                )
            }
            VStack (spacing: 8.0) {
                Spacer()
                Image(systemName: "minus")
                    .font(.system(size: 56.0))
                    .foregroundColor(Color("Bg"))
                VStack (spacing: 16.0) {
                    HStack {
                        Text("Адреса магазинов")
                            .bold()
                            .foregroundColor(Color("Gray"))
                        Spacer()
                        Menu {
                            Button("По цене", action: {
                                sort = .byPrice
                            })
                            Button("По расстоянию", action: {
                                sort = .byDistance
                            })
                        } label: {
                            Button("Сортировка") {
                                // some do
                            }
                            .buttonStyle(AdditionalButton())
                        }
                    }
                    ScrollView {
                        VStack (spacing: 16.0) {
                            ForEach (shops.sorted{
                                switch sort {
                                    case .byPrice: return $0.price < $1.price
                                    case .byDistance: return $0.km < $1.km
                                }
                            }, id: \.id) { item in
                                HStack (spacing: 8.0) {
                                    VStack (spacing: 8.0) {
                                        HStack {
                                            Text(item.location)
                                            Spacer()
                                        }
                                        HStack (spacing: 8.0) {
                                            Text("Стоимость:")
                                                .font(.caption)
                                            Text("\(item.price) руб.")
                                                .font(.subheadline)
                                                .foregroundColor(Color("Colar"))
                                            Spacer()
                                            Text("До магазина:")
                                                .font(.caption)
                                            Text("\(String(format: "%.1f", item.km)) км")
                                                .font(.subheadline)
                                        }
                                    }
                                    Spacer()
                                    Button (action: {
                                        cart.addItem(item: ItemCart(inTitle: title, inLocation: item.location, inPrice: item.price))
                                        cart.calcTotals()
                                        showAlert.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 24.0))
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.all, 16.0)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/3)
                .background(Color("Bg"))
                .opacity(0.9)
                .cornerRadius(40.0)
                .alert(isPresented: $showAlert) {
                    Alert (title: Text("Будильник цен"), message: Text("Хочешь узнать первым об изменениях цены на этот товар?"),
                           primaryButton: .default(Text("Хочу"), action: {
                            UserDefaults.standard.setValue(title, forKey: "alarm")
                            showAlert.toggle()
                           }),
                           secondaryButton: .destructive(Text("Позже"))
                    )
                }
            }
        }
        .navigationBarTitle(title)
        .onAppear {
            randomShops()
        }
    }
}

struct ProductView: View {
    @State var title: String
    @State var location: String
    @State var price: Int
    @State private var region = MKCoordinateRegion()
    @State var shops = [AnnotationItem]()
    @State var isFull = true
    @State var offset: CGFloat = .zero
    
    private func getLocation () {
        getCoordinate(addressString: location) { coordinates, error in
            if error == nil {
                region.center = coordinates
                region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                shops.append(AnnotationItem(coordinate: coordinates))
            }
        }
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: shops) { item in
                MapMarker(
                    coordinate: item.coordinate,
                    tint: Color("Colar")
                )
            }
            if isFull {
                VStack (spacing: 8.0) {
                    Spacer()
                    Image(systemName: "minus")
                        .font(.system(size: 56.0))
                        .foregroundColor(Color("Bg"))
                    VStack (spacing: 16.0) {
                        Rectangle()
                            .foregroundColor(Color("Gray"))
                            .frame(maxHeight: 200.0)
                            .aspectRatio(contentMode: .fill)
                        VStack (spacing: 24.0) {
                            VStack (spacing: 8.0) {
                                HStack {
                                    Text(title)
                                        .bold()
                                        .lineLimit(2)
                                    Spacer()
                                }
                                HStack (spacing: 4.0) {
                                    Image(systemName: "location.fill.viewfinder")
                                    Text(location)
                                    Spacer()
                                }
                                .font(.caption)
                                .opacity(0.8)
                            }
                            VStack (spacing: 8.0) {
                                HStack {
                                    Text("Состав")
                                        .font(.caption)
                                        .opacity(0.8)
                                    Spacer()
                                }
                                HStack {
                                    Text("Вода, мука, рожь, овес, соль, перец")
                                        .lineLimit(2)
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                            Button (action: {
                                //some do
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Будильник")
                                    Spacer()
                                }
                            }
                            .buttonStyle(ColarButton())
                        }
                        .padding(.horizontal, 16.0)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2)
                    .background(Color("Bg"))
                    .opacity(0.9)
                    .cornerRadius(40.0)
                }
                .gesture(DragGesture()
                    .onEnded { _ in
                        isFull.toggle()
                    }
                )
            } else {
                VStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isFull.toggle()
                        }
                    }) {
                        HStack {
                            Text(title)
                                .font(.subheadline)
                                .bold()
                                .lineLimit(1)
                            Spacer()
                            Text(location)
                                .font(.caption)
                                .lineLimit(1)
                        }
                        .padding()
                    }
                    .background(Color("Bg"))
                    .opacity(0.96)
                    .cornerRadius(16.0)
                    .padding()
                }
            }
        }
        .onAppear {
            getLocation()
        }
    }
}

struct ProductPreviewView: View {
    @EnvironmentObject var cart: CartData
    @State var title: String
    @State var location: String
    @State var price: Int
    @State var favorite: Bool = false
    @State var from: Bool = false
    @State var link: Int? = nil
    let locations = ["Москва, Вернадского 8", "Москва, Вернадского 19"]
    
    var body: some View {
        ZStack {
            NavigationLink (destination: ProductView(title: title, location: location, price: price), tag: 1, selection: $link) {
                EmptyView()
            }
            NavigationLink (destination: ProductsListView(title: title, locations: locations), tag: 2, selection: $link) {
                EmptyView()
            }
            VStack (spacing: 16.0) {
                Rectangle()
                    .foregroundColor(Color("LightTheme"))
                    .aspectRatio(1.0, contentMode: .fit)
                    .cornerRadius(8.0)
                    .overlay(
                        VStack {
                            HStack {
                                Spacer()
                                Button (action: {
                                    // some do
                                }) {
                                    Image(systemName: favorite ? "heart.fill" : "heart")
                                        .foregroundColor(Color("Colar"))
                                        .font(.system(size: 20.0))
                                }
                                .padding(.all, 8.0)
                            }
                            Spacer()
                        }
                    )
                Group {
                    HStack {
                        Text(title)
                            .lineLimit(2)
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack (alignment: .top, spacing: 4.0) {
                        Image(systemName: "location.fill.viewfinder")
                        Text(location)
                            .lineLimit(2)
                        Spacer()
                    }
                    .font(.caption)
                    .foregroundColor(Color("Gray"))
                }
                .multilineTextAlignment(.leading)
                Button(action: {
                    // add in cart
                }) {
                    HStack (alignment: .center, spacing: 4.0) {
                        Spacer()
                        Text("\(from ? "от " : "")\(String(price))")
                            .lineLimit(1)
                        if !from {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .onTapGesture {
                link = from ? 2 : 1
            }
        }
    }
}
