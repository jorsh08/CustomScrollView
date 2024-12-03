//
//  Home.swift
//  CustomScrollView
//
//  Created by Jorge Verdugo on 01/12/24.
//

import SwiftUI

struct Home: View {
    
    @State private var tabs: [TabModel] = [
        .init(id: TabModel.Tab.research),
        .init(id: TabModel.Tab.deployment),
        .init(id: TabModel.Tab.analyrics),
        .init(id: TabModel.Tab.audience),
        .init(id: TabModel.Tab.privacy),
    ]
    
    @State private var activeTab: TabModel.Tab = .research
    @State private var mainViewScrollState: TabModel.Tab?
    @State private var tabBarScrollState: TabModel.Tab?
    var body: some View {
        VStack{
            CustomTabBar()
            GeometryReader {
                let size = $0.size
                ScrollView(.horizontal){
                    LazyHStack(spacing: 0){
                        ForEach(tabs) { tab in
                            Text(tab.id.rawValue)
                                .frame(width: size.width, height: size.height)
                                .contentShape(.rect)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .onChange(of: mainViewScrollState) { oldValue, newValue in
                    if let newValue {
                        withAnimation(.snappy) {
                            tabBarScrollState = newValue
                            activeTab = newValue
                            print(newValue)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        ScrollView(.horizontal){
            HStack (spacing: 0){
                ForEach(tabs) { tab in
                    Button(action: {
                        withAnimation(.snappy) {
                            activeTab = tab.id
                            mainViewScrollState = tab.id
                            tabBarScrollState = tab.id
                        }
                    }, label: {
                        Text(tab.id.rawValue)
                            .padding(15)
                            .padding(.vertical, 12)
                            .foregroundStyle( activeTab == tab.id ? Color.primary : .gray)
                            .contentShape(.rect)
                    })
                }
            }
        }
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
            
        }), anchor: .center)
        .safeAreaPadding(.horizontal, 15)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    Home()
}
