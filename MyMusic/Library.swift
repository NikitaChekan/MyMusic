//
//  Library.swift
//  MyMusic
//
//  Created by jopootrivatel on 31.03.2023.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("WTF")
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            self.tracks = UserDefaults.standard.savedTracks()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(#colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1)))
                                .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
                                .cornerRadius(10)
                        }
                    }
                }.padding().frame(height: 50)
                
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
                
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track)
                            .gesture(LongPressGesture().onEnded { _ in
                                self.track = track
                                self.showingAlert  = true
                            }.simultaneously(with: TapGesture().onEnded { _ in
                                self.track = track
                                self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                            }))
                    }.onDelete(perform: delete)
                }
            }
            .actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure want to delete this Track?"), buttons: [.destructive(Text("Delete"), action: {
                    self.delete(track: self.track)
                }), .cancel()])
            })
            .navigationBarTitle("Library")
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        
        if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
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
