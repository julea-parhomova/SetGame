//
//  SetGameView.swift
//  SetGame
//
//  Created by Julea Parkhomava on 1/23/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: ViewModel
    @State var onScreen = false
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 10){
                Button(action:
                        {
                            withAnimation{
                                viewModel.newGame()
                            }}
                ){
                    Text("New Game")
                }
                Button(action:
                        {
                            withAnimation{
                                viewModel.help()
                            }}
                ){
                    Text("Help")}
            }
            .opacity(onScreen ? 1 : 0)
            Grid(viewModel.cards){card in
                Group{
                    if(onScreen){
                        CardView(card: card)
                            .padding()
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    viewModel.choose(card: card)
                                }
                            }
                    }
                }
            }
            .onAppear{
                withAnimation(Animation.easeIn(duration: 3).delay(2)){
                    onScreen = true
                }
            }
        }
    }
}

struct CardView: View{
    var card: Model.Card
    var cardColor: Color
    init(card: Model.Card){
        self.card = card
        cardColor = card.colorOfElements == Model.Card.colorElement.blue ? Color.blue : ((card.colorOfElements == Model.Card.colorElement.red) ? Color.red : Color.green)
    }
    var body: some View{
        if(!card.isMatched ){
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .shadow(color: .black,
                            radius: !card.isSelect ? 2 : 5,
                            x: !card.isSelect ? -2 : -5,
                            y: !card.isSelect ? 2 : 5)
                    .border(
                        !card.isSelect ? Color.black : Color.yellow,
                        width: !card.isSelect ? 3 : 4)
                VStack(){
                    ForEach(0..<card.numberOfElements, id: \.self){_ in
                        GeometryReader{ geometry in
                            Group{
                                switch card.shapeOfElements {
                                case Model.Card.ShapeElement.oval:
                                    Oval()
                                case Model.Card.ShapeElement.rhombus:
                                    Rhombus()
                                case Model.Card.ShapeElement.snake:
                                    Snake()
                                }
                            }
                            .modifier(differentFill(fillType: card.fillOfElements == Model.Card.fillElement.empty ? .empty : (card.fillOfElements == Model.Card.fillElement.full ? .full : .stroke), borderWidth: nil, contentSize: geometry.size, colorOfElement: cardColor))
                        }
                    }
                }
                .padding(10)
            }.transition(AnyTransition.flyCards)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: ViewModel())
    }
}
