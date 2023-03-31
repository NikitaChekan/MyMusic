//
//  Library.swift
//  MyMusic
//
//  Created by jopootrivatel on 31.03.2023.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("WTF")
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(.pink)
                                .background(.gray)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            print("WTF2")
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(.pink)
                                .background(.gray)
                                .cornerRadius(10)
                        }
                    }
                }.padding().frame(height: 50)
                
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
                                
                List {
                    LibraryCell()
                }
            }
            .navigationBarTitle("Library")
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image("track")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(2)
            VStack(alignment: .leading) {
                Text("Track Name")
                Text("Artist Name")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
