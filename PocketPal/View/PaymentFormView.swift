//
//  PaymentFormView.swift
//  PocketPal
//
//  Created by Aman Gupta on 19/02/24.
//

import SwiftUI

struct PaymentFormView: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var paymentFormViewModel: PaymentFormViewModel
    
    var payment: PaymentActivity?
    
    init(payment: PaymentActivity?=nil){
        self.payment = payment
        self.paymentFormViewModel = PaymentFormViewModel(paymentActivity: payment)
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                HStack(alignment:.lastTextBaseline){
                    Text("New Payment")
                        .font(.system(.largeTitle,design: .rounded))
                        .fontWeight(.black)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    Button(action:{self.presentationMode.wrappedValue.dismiss()}){
                        Image(systemName:"multiply")
                            .font(.title)
                            .foregroundColor(.primary)
                        
                    }
                }
                
                Group{
                    if !paymentFormViewModel.isNameValid{
                        ValidationErrorText(text:"Please enter the payment name")
                        
                    }
                    if !paymentFormViewModel.isAmountValid{
                        ValidationErrorText(text:"Please enter the correct amoutn")
                    }
                    
                    if !paymentFormViewModel.isMemoValid{
                        ValidationErrorText(text:"Your memo should not exceed above 300 charachters")
                        
                    }
                }
                
                FormTextField(name:"Name",placeholder:"Enter you Amount",value:$paymentFormViewModel.name)
                    .padding(.top)
                VStack(alignment: .leading){
                    Text("Type")
                        .font(.system(.headline))
          
                    
                    HStack(spacing:0){
                        Button(action:{
                            self.paymentFormViewModel.type = .income
                        }){
                            Text("Income")
                                .font(.headline)
                                .foregroundColor(self.paymentFormViewModel.type == .income ? Color.white : Color.primary )
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(self.paymentFormViewModel.type == .income ? Color("IncomeCard") : Color(.systemBackground))
                        Button(action:{
                            self.paymentFormViewModel.type = .expense
                        }){
                            Text("Expense")
                                .font(.headline)
                                .foregroundColor(self.paymentFormViewModel.type == .expense ?
                                                 Color.white : Color.primary)
                        }
                        .frame(minWidth:0.0, maxWidth: .infinity)
                        .padding()
                        .background(self.paymentFormViewModel.type == .expense ?
                                    Color("ExpenseCard") : Color(.systemBackground))
                        
                        
                    }
                    .border(Color("Border"),width:1.0)
                    
                    
                }
                .padding(.top)
                
                HStack{
                    FormDateField(name:"Date",value: $paymentFormViewModel.date)
                    FormTextField(name:"Amount ($)",placeholder:"",value: $paymentFormViewModel.amount)
                }
                .padding(.top)
                
                FormTextEditor(name:"Memo(Optional)", value: $paymentFormViewModel.memo)
                    .padding(.top)
                
            }
        }
        .padding()
    }
}

struct FormTextField: View{
    let name: String
    var placeholder: String
    
    @Binding var value: String
    
    var body: some View{
        VStack(alignment: .leading){
            Text(name.uppercased())
                .font(.system(.subheadline,design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            TextField(placeholder,text: $value)
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .border(Color("Border"),width: 1.0)
            
        }
    }
}

struct FormDateField: View{
    let name: String
    @Binding var value: Date
    var body: some View{
        VStack(alignment: .leading){
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            DatePicker("",selection: $value, displayedComponents: .date)
                .accentColor(.primary)
                .padding(10)
                .border(Color("Border"),width: 1)
                .labelsHidden()
        }
        
    }
    
}


struct FormTextEditor: View{
    let name: String
    let height: CGFloat = 80.0
    
    @Binding var value: String
    
    var body: some View{
        VStack(alignment: .leading){
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            TextEditor(text: $value)
                .frame(minHeight: height)
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .border(Color("Border"),width:1.0)
                
        }
    }
    
}
struct ValidationErrorText: View{
    var iconName: String = "info.circle"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    var text = ""
    var body: some View{
        
        HStack{
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
            Spacer()
            
        }
    }
}

#Preview {
    PaymentFormView()
}
