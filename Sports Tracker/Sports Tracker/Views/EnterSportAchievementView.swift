//
//  SportAchievementView.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import SwiftUI
import MapKit

struct EnterSportAchievementView: View {
    @EnvironmentObject var achievements: Achievements
    @ObservedObject private var viewModel = SportsViewModel()
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Activity Name *")) {
                        TextField("Enter activity name", text: $viewModel.activityName)
                    }

                    Section(header: Text("Activity Duration")) {
                        HStack {
                            TextField("Hours", text: $viewModel.activityDurationHours)
                                .keyboardType(.numberPad)
                            TextField("Minutes", text: $viewModel.activityDurationMinutes)
                                .keyboardType(.numberPad)
                        }
                    }

                    Section {
                        Picker("Where do you want to store?", selection: $viewModel.saveType) {
                            ForEach(viewModel.saveType.storeTypes, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }

                    Button("Select location") {
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        HStack {
                            Button("Cancel") {
                                isPresented = false
                                viewModel.centerCoordinate = CLLocationCoordinate2D()
                            }
                            .padding()
                            .frame(alignment: .leading)
                            Spacer()
                            Button("Select") {
                                isPresented = false
                            }
                            .padding()
                        }
                        ZStack {
                            MapView(centerCoordinate: $viewModel.centerCoordinate)
                            Circle()
                                .fill(Color.blue)
                                .opacity(0.3)
                                .frame(width: 32, height: 32)
                        }
                    }
                }

                Button("Add Activity") {
                    achievements.saveToDatabase(type: viewModel.saveType, activity: viewModel.activity)
                    achievements.addSport(activity: viewModel.activity)
                    UIApplication.shared.endEditing()
                }
                .disabled(viewModel.activityName.isEmpty)
                .padding()
                .font(.body)
                .background(viewModel.activityName.isEmpty ? Color.gray : Color.green)
                .foregroundColor(.white)
                .clipShape(Capsule())
                Spacer()
            }
            .navigationTitle("Create activity")
        }
    }
}

struct SportAchievementView_Previews: PreviewProvider {
    static var previews: some View {
        EnterSportAchievementView()
            .environmentObject(Achievements())
    }
}
