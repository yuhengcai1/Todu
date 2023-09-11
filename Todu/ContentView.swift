//
//  ContentView.swift
//  Todu
//
//  Created by 蔡雨衡 on 9/11/23.
//

import SwiftUI

struct Havefun: Identifiable {
  let id    = UUID()
  var isOn  = true
  let Fun: String
}

struct ContentView: View {
    

    
    @StateObject private var viewModel = FunViewModel()
    
    @State private var newFun: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("GET NEW ONE", text: $newFun)
                Button("Confirm") {
                    let newItem = Havefun(Fun: newFun)
                    viewModel.append(newItem)
                    newFun = ""
                }
            }
            .padding()
            List {
                ForEach(viewModel.More) { item in
                    HStack{
                        Text(item.Fun).foregroundColor(item.isOn ? .blue : .gray)
                        Spacer()
                        Group {
                                      if item.isOn {
                                        Image(systemName: "circle")
                                      }
                                      else {
                                        Image(systemName: "heart.fill")
                                      }
                    }
                        .foregroundColor(.gray)
                        .onTapGesture {
                                      viewModel.toggle(item)
                        }
                    }
                    
                }
            }
        }
    }
}


class FunViewModel: ObservableObject {
  @Published private(set) var More: [Havefun]

  init() {
    self.More = [
        Havefun(Fun: "Yuheng"),
        Havefun(Fun: "Cai"),
        Havefun(Fun: "Apple")
    ]
  }

  func append(_ item: Havefun) {
    More.append(item)
  }

  func toggle(_ item: Havefun) {
    if let index = More.firstIndex(where: {$0.id == item.id}) {
      More[index].isOn.toggle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



