//
//  FishDetail.swift
//  fisherApp
//
//  Created by Theo Marie on 24/06/2024.
//

import SwiftUI



struct FishDetail: View {
    
    var fish: FishSaved_Model
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Profile Picture and Name
                HStack {
                  
                        
                        Image(fish.picture)
                            .resizable()
                            .frame(minHeight: 250, idealHeight: 200)
                            .aspectRatio(contentMode: .fill)
                            .overlay(content: {
                                GeometryReader { geometry in
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text(fish.size >= fish.breed.minSize && fish.size <= fish.breed.maxSize && fish.breed.fishable ? "Gardable" : "À Libérer")
                                                .font(.headline)
                                                .padding(8)
                                                .background(fish.size >= fish.breed.minSize && fish.size <= fish.breed.maxSize && fish.breed.fishable ? Color.green : Color.red)
                                                .cornerRadius(10)
                                                .foregroundColor(.white)
                                                .padding([.bottom, .trailing], 10)
                                        }
                                    }
                                }
                            })
                            
                    
                }
                
                // Fish Information
                VStack(alignment: .leading, spacing: 10) {
                    Text("Informations")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(fish.stats) { stat in
                                StatView(statName: stat.statName, statValue: stat.statValue, iconValue: stat.iconValue)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                
                
                
                // Existing Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Renseignement")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(fish.breed.statsBreed) {
                            stat in
                            ActivityView(activityName: stat.statName, activityValue: stat.statValue, iconValue: stat.iconValue)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitle(fish.title, displayMode: .large)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FishDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FishDetail(fish: FishSaved_Model(title: "Patoche", breed: BreedSaved_Model(name: "Yellowfin", minSize: 11.1, maxSize: 20.2, fishable: true, storageTemp: "0-5°C"), size: 13.8, date: "2023-07-20", isFavorite: false, picture: "Bangus91"))
        }
    }
}

