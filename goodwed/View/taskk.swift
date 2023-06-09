//
//  Home.swift
//  TaskManager
//
//  Created by OmarKaabi on 8/5/2023.
//

import SwiftUI

struct Task: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack(spacing: 15, pinnedViews: [ .sectionHeaders]) {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                     
                        HStack(spacing: 10){
                            
                            ForEach(taskModel.currentWeek,id: \.self){ day in
                                
                                VStack(spacing: 10){
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8,height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0)
                                
                                }
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                .frame(width: 45,height: 90)
                                .background(
                                    ZStack{
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation{
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                    TasksView()
                } header: {
                    HeaderView()
                }
                
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    func TasksView() -> some View{
        
        LazyVStack(spacing: 25){
            
            if let tasks = taskModel.filteredTasks{
                
                if tasks.isEmpty{
                    
                    Text("No tasks found ??")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                }
                else {
                    ForEach(tasks){task in
                        TaskCardView(task: task)
                        
                    }
                }
            }
            else {
                ProgressView()
                    .offset(y: 100)
            }
            
        }
        .padding()
        .padding(.top)
        .onChange(of: taskModel.currentDay){newValue in
            taskModel.filterTodayTasks()
            
        }
        
    }
    
    func TaskCardView(task: checklist)->some View{

        
        HStack(alignment: .top, spacing: 30){
            VStack(spacing: 10){
                Circle()
                    .fill(taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)) ? .black : .clear)
                    .frame(width: 15,height: 15)
                    .background(
                    Circle()
                        .stroke(.black,lineWidth: 1)
                        .padding(-3)
                    )
                    .scaleEffect(taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)) ? 0.8 : 1)
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            VStack{
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12){
                        
                        Text(task.nom)
                            .font(.title2.bold())
                        
                        Text(task.type)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .hLeading()
                    
                    Text(taskModel.formatDate(date: task.date).formatted(date: .omitted, time: .shortened))
                }
                
                if taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)){
                    HStack(spacing: 0){
                        
                        HStack(spacing: -10){
                            
                            ForEach(["User1","User2","User3"],id: \.self){user in
                                
                                Image(user)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45,height: 45)
                                    .clipShape(Circle())
                                    .background(
                                    Circle()
                                        .stroke(.white,lineWidth: 5)
                                    )
                                
                            }
                        }
                        .hLeading()
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(Color.gray,in: RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }.padding(.top)
                }
                
                
            }
            .foregroundColor(taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)) ? .white : .black)
            .padding(taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)) ? 15 : 0)
            .padding(.bottom,taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)) ? 0 : 10)
            .hLeading()
                .background(
                    Color(.black)
                    .cornerRadius(25)
                    .opacity(taskModel.isCurrentHour(date: taskModel.formatDate(date: task.date)) ? 1 : 0)
                )
            
        }
        .hLeading()
    }
    
    
    func HeaderView()->some View{
        HStack (spacing: 10){
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button{
                
            } label: {
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
    
        }
        .padding()
        .padding(.top,getSafeArea().top)
        .background(Color.white)
    }
    
}
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Task()
        }
    }
    
    extension View {
        func hLeading()->some View {
            self
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        
        func hTrailing()->some View {
            self
                .frame(maxWidth: .infinity,alignment: .trailing)
        }
        
        func hCenter()->some View {
            self
                .frame(maxWidth: .infinity,alignment: .center)
        }
        
        func getSafeArea()->UIEdgeInsets{
            guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                return .zero
            }
            
            guard let safeArea = screen.windows.first?.safeAreaInsets else{
                return .zero
            }
            
            return safeArea
        }
    }
    

