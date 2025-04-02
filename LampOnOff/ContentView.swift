//
//  ContentView.swift
//  LampOnOff
//
//  Created by Mark Vadimov on 18.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State var speedSl = 15.0
    @State var light = false
    @State var viewSwitch = CGSize.zero
    
    var body: some View {
        VStack{
            VStack {
                HStack{
                    VStack{
                        Image("lamp")
                            .resizable()
                            .frame(width: 325, height: 450)
                        
                        VStack{
                            if light {
                                Trapezoid()
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(speedSl / 100), Color.white.opacity(0.005)]), startPoint: .top, endPoint: .bottom))
                                    .frame(width: 120, height: 300)
                                    .offset(y: -15)
                                    
                            }
                        }
                        .frame(width: 150, height: 300)
                        .animation(.easeInOut(duration: 0.25))
                    }
                    .offset(x: 15)
                    
                    VStack{
                        Rectangle()
                            .frame(width: 5, height: 1000)
                            .foregroundStyle(Color.white.opacity(0.6))
                        
                        
                        Rectangle()
                            .frame(width: 50, height: 100)
                            .cornerRadius(50)
                            .foregroundStyle(Color.grayBG)
                            .padding(5)
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(50)
                            .offset(y: -50)
                    }
                    .offset(y: -450)
                    .offset(y: viewSwitch.height)
                    .animation(.spring(response: 0.45, dampingFraction: 0.5, blendDuration: 0))
                    .gesture(
                        DragGesture().onChanged { value in
                            self.viewSwitch = value.translation
                        }
                            .onEnded { value in
                                if self.viewSwitch.height >= 275 {
                                    self.light.toggle()
                                }
                                self.viewSwitch = .zero
                            }
                    )
                    
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: 765)
                Spacer()
                
            }
            if light{
                VStack{
                    Text("Power: \((speedSl / 100).formatted())")
                        .font(.system(size: 29))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    
                    HStack(spacing: 0){
                        Image(systemName: "triangle.fill")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundStyle(Color.white)
                            .rotationEffect(Angle(degrees: -90))
                            .onTapGesture{
                                if speedSl != 10 {
                                    speedSl -= 5
                                }
                            }
                        
                        
                        Slider(value: $speedSl, in: 10...25, step: 5)
                            .frame(width: 250, height: 20)
                            .accentColor(.white)
                        
                        Image(systemName: "triangle.fill")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundStyle(Color.white)
                            .rotationEffect(Angle(degrees: 90))
                            .onTapGesture{
                                if speedSl != 25 {
                                    speedSl += 5
                                }
                            }
                    }
                }
                .frame(width: 375, alignment: .leading)
                .offset(y: -50)
            }
            HStack{
                Spacer()
                
                Text(light ? "On" : "Off")
                    .font(.system(size: 26))
                    .frame(width: 40)
                    .foregroundStyle(light ? Color.green : Color.red)
                    .fontWeight(.bold)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 30)
                    .padding(.trailing, 15)
                    .padding(.bottom, 10)
                    .background(light ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                    .cornerRadius(10)
                    .shadow(color: light ? Color.green : Color.red, radius: 20, x: -6, y: -10)
                    .offset(x: 5, y : 10)
                
            }
            .frame(width: UIScreen.main.bounds.width)
            
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.grayBG)
    }
}

#Preview {
    ContentView()
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX - 70, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX + 70, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}



