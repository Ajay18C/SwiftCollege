class ConvertStrToInt{
  func convert(target:String?)->Int{
    let str=target
    return ((str.flatMap{Int($0)}) ?? 0)
  }
}
class Student:ConvertStrToInt{
  var name:String
  var registrationNumber:String
   var isFiratGraduate:Bool
  private var percentage10:String
  private var percentage12:String
  var fees:Int
  init(name:String){
    self.name=name
    print("Enter the Register number of the student")
    self.registrationNumber=readLine() ?? ""
    print("Student First graduate ?(true/false)")
    self.isFiratGraduate=Bool(readLine() ?? "") ??  false
    print("Enter the sslc percentage of the student")
    self.percentage10=readLine() ?? "0%"
    print("Enter the hsc percentage of the student")
    self.percentage12=readLine() ?? "0%"
    print("Enter the fee of the student ")
    self.fees=Int(readLine() ?? "1000") ?? 1000
  }
  func getmark10()->String{
    return self.percentage10
  }
  func getmark12()->String{
    return self.percentage12
  }
}
class Teacher{
   private var name:String
  var idNumber:String
  var salary:Int
  var experience:Int
  init(name:String){
  self.name=name
    print("Enter the Id number of the student")
    self.idNumber=readLine() ?? ""
    print("Enter the Salary of the teacher")
    self.salary=Int(readLine() ?? "0") ?? 0
    print("Enter the Experience of the teacher")
    self.experience=Int(readLine() ?? "0") ?? 0
  }
  func teacherMain(){
    print("Enter your choice : \n\n1 . MANAGE TEACHERS 2 . MANAGE SALARY \n")
  }
  
}
class Admin:ConvertStrToInt{
  func adminMain(){
    print("Enter your choice : \n\n1 . MANAGE TEACHERS 2 . MANAGE SALARY \n")
    let manageType=readLine()
    self.switchChoice(choice:super.convert(target:manageType))
  }
  func switchChoice(choice:Int){
  switch(choice){
    case 1:
    print("1 . ADD TEACHER 2 . REMOVE TEACHER")
    let type=readLine()
    switch(super.convert(target:type )){
    case 1:
      print("Enter Name of the Teacher")
      let addTeacher=Teacher(name:readLine() ?? "")
      teachersRecords.append(addTeacher)
      print("Teacher ADDED")
      case 2:
      print("Enter the Id no of teacher to remove :")
      let removeTeacher=readLine() ?? ""
      if(teachersRecords.contains{$0.idNumber==removeTeacher}){
      teachersRecords.remove(at:(teachersRecords.firstIndex(where:{$0.idNumber == removeTeacher}))!)
      print("Teacher REMOVED")
      }
      else{
        print("NO SUCH TEACHER FOUND")
        break
      }
      default:
      break
    }
    case 2:
    if(teachersRecords.count>0){
      let salaryList=teachersRecords.map{$0.salary+($0.experience*1000)}
      for (teacherlis,salary) in zip(teachersRecords,salaryList){
        teacherlis.salary=salary
      }
print("SALARY updated ")
    }
    else{
      print("no teacher to give salary")
    }
    default:
   break
  }
   }
}
class Main:ConvertStrToInt{
  func switchUser(choice:Int){
    switch(choice){
      case 1:
      print("\t\t\tUSERMODE: ADMIN\t\t\t\n")
      let adminMode=Admin()
      adminMode.adminMain()
      case 2:
      print("\t\t\tUSERMODE: TEACHER\t\t\t\n")
      print(" 1 . MANAGE STUDENTS 2 . APPLY SCHOLARSHIP TO ALL")
      switch(convert(target:readLine())){
    case 1:
    print("1 . ADD STUDENT 2 . REMOVE STUDENT")
    let type=readLine()
    switch(super.convert(target:type )){
    case 1:
      print("Enter Name of the Student")
      let addStudent=Student(name:readLine() ?? "")
      studentsRecords.append(addStudent)
      print("STUDENT ADDED")
      case 2:
      print("Enter the reg no of student to remove :")
      let removeStudent=readLine() ?? ""
      if(studentsRecords.contains{$0.registrationNumber==removeStudent}){
      studentsRecords.remove(at:(studentsRecords.firstIndex(where:{$0.registrationNumber == removeStudent}))!)
      print("Student REMOVED")
      }
      else{
        print("NO SUCH Student FOUND")
        break
      }
      default:
      break
    }
    case 2:
    if(studentsRecords.count>0){
      let feesList=studentsRecords.map{($0.isFiratGraduate ?$0.fees-($0.fees)/4:$0.fees)}
      for (feeslis,fee) in zip(studentsRecords,feesList){
        feeslis.fees=fee
      }
print("Scholarship sucessfully applied")
    }
    else{
      print("no student to apply Scholarship")
    }
    default:
   break
  }
      case 3:
      print("\t\t\tUSERMODE: STUDENT\t\t\t\n")
      print("Enter the reg no of the student to see the details of the student")
      let searchRegNo=readLine() ?? ""
      if(studentsRecords.contains{$0.registrationNumber==searchRegNo}){
        let details=studentsRecords.filter({$0.registrationNumber == searchRegNo})[0]
        print("Name:\(details.name)\nRegisterNumber:\(details.registrationNumber)\nFirstGraduate:\(details.isFiratGraduate ? "yes":"N0")\nSSLC%:\(details.getmark10())\nHSC%:\(details.getmark12())\nFees:\(details.fees)")
      }
      default:
      print("\t\t\tUSERMODE: VISITOR\t\t\t\n")
      print("Total no of students in the college\t\(studentsRecords.count)")
      print("Total no of teachers in the college\t\(teachersRecords.count)")
      print("Total no of FirstGraduate students in college\t\(studentsRecords.filter({$0.isFiratGraduate}).count)")
      print("Total no of experienced teachers\t\(teachersRecords.filter({$0.experience>0}).count)")
      print("Total Earnings of college\t\(studentsRecords.map{$0.fees}.reduce(0,+))")
      print("Total Expenditure of college\t\(teachersRecords.map{$0.salary}.reduce(0,+))")
      let turnOver=(studentsRecords.map{$0.fees}.reduce(0,+))-(teachersRecords.map{$0.salary}.reduce(0,+))
      if(turnOver>0){
        print("Monthly profit \t\(turnOver)")
      }
      else{
        print("Monthly loss \t\(abs(turnOver))")
      }
    }
  }
  public func main(){
    print("Enter your user type : \n\n 1 . ADMIN  2 . TEACHER  3 . STUDENT  4 . VISITOR \n")
    let userType=readLine()
    self.switchUser(choice:super.convert(target:userType))
  }
}
var studentsRecords=[Student]()
var teachersRecords=[Teacher]()
while(true){
let start=Main()
start.main()
}