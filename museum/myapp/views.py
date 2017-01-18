from django.shortcuts import render
from django.db import connection
from django.http import HttpResponse,HttpResponseRedirect
import MySQLdb
from django.contrib.auth.models import User
from django.contrib import auth
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout

# Create your views here.
from forms import LoginForm

def check_text(s) : 
	for c in s : 
		ch = ord(c)
		if ch>122 or ch<65 : return False;
		if ch>90 and ch<97 : return False
	return True

def check_number(s) : 
	for c in s :
		ch = ord(c)
		if ch>=48 and ch<=57 : return True
		return False	

def check_dob(s) :
	from datetime import datetime
	l = s.split('-')
	if len(l)!=3 : return False
	if len(l[0])!=4 or len(l[1])!=2 or len(l[2])!=2 : return False;
	if not check_number(l[0]) or not check_number(l[1]) or not check_number(l[2]) : 
		return False
	#date = datetime.strptime(s, "%Y-%m-%d").date()
	date = datetime(int(l[0]), int(l[1]), int(l[2]))
	return date < datetime.now()

def check_time(s) : 
	from datetime import datetime
	l = s.split(':')
	if len(l)!=3 : return False
	if len(l[0])!=2 or len(l[1])!=2 or len(l[2])!=2 : return False;
	if not check_number(l[0]) or not check_number(l[1]) or not check_number(l[2]) : 
		return False
	return True
	

def check_dob_fwd(s) :
	from datetime import datetime
	l = s.split('-')
	if len(l)!=3 : return False
	if len(l[0])!=4 or len(l[1])!=2 or len(l[2])!=2 : return False;
	if not check_number(l[0]) or not check_number(l[1]) or not check_number(l[2]) : 
		return False
	date = datetime(int(l[0]), int(l[1]), int(l[2]))
	return date > datetime.now()

def index(request):
	form = LoginForm(request.POST or None)
	context = {"form":form}
	if form.is_valid():
		fullname = form.cleaned_data["fullname"]
		password = form.cleaned_data["password"]	
		c = connection.cursor()
		c.execute("select * from EMPLOYEE where Name = %s and Emp_Password = %s", (fullname,password,))
		if c.rowcount != 0 :
			return render(request, "display_data.html", context)
		else : 
			print "Record not found in the database."
		context["form"] = None

		
	return render(request,"forms.html",context)

def save_visitor_auth() :
	c = connection.cursor()
	c.execute("select Visitor_ID, Name from VISITOR")
	rows = c.fetchall()
	for row in rows :
		username = row[1]
		password = str(row[0])
		user = auth.authenticate(username=username,email="Visitor",password=password)
		if user is None :
			user1 = User.objects.create_user(username,"Visitor",password)
			user1.save()

def remove_employee_auth() :
	c = connection.cursor()
	c.execute("select Emp_ID, Name from EMPLOYEE")
	rows = c.fetchall()
	for row in rows :
		username = row[1]
		password = str(row[0])
		user = auth.authenticate(username=username,email="Visitor",password=password)
		user.delete()

def loginform(request) :

	if request.method=="POST" :
		context = {}
		fullname = request.POST.get('fullname')
		password = request.POST.get('password')
		context["Name"] = fullname
		option = request.POST.get('options')
		if option == "Admin" : 
			user = auth.authenticate(username=fullname,email="Admin",password=password)
			if user is not None :
				auth.login(request,user)
				return HttpResponseRedirect('/administrator/')
			else :
				return HttpResponse("signup unsuccessful!")
		else :
			print "kaam to kar rha hai"
			user = auth.authenticate(username=fullname,password=password)
			if user is not None and not(fullname=="Devang" and password=="mirajeev") :
				auth.login(request,user)
				return HttpResponseRedirect('/visitorpage/')
			else :
				return HttpResponse("signup unsuccessful!")

	# 	c = connection.cursor()
	# 	c.execute("select * from EMPLOYEE where Name = %s and Emp_Password = %s", (fullname,password,))
	# 	if c.rowcount != 0 :
	# 		return render(request, "display_data.html", context)
	# 	return HttpResponse("signup unsuccessful!")
	user = auth.authenticate(username="Devang",email="Admin",password="mirajeev")
	if user is None :
		user1 = User.objects.create_user("Devang","Admin","mirajeev")
		user1.save()
	save_visitor_auth()

	return HttpResponse(render(request,"loginform.html"))	


def home(request):
	try:
 		c = connection.cursor()
 		c.execute("select * from EMPLOYEE")
 		row = c.fetchone()
 		print row
 	
 	except Exception,e:
 		print repr((e[1]))
 	finally:
 		c.close()
 	'''
 	db = MySQLdb.connect("localhost","root","123","STUDENTS")
 	c = db.cursor()
 	#c.execute("select * from STUDENTS")
 	sql = " INSERT INTO STUDENTS(ROLL,NAME,DEPT) VALUES ('%d', '%s', '%s' )" % (456985, 'Mohan','BIOMED')
 	c.execute(sql)
 	db.commit()
 	#row = c.fetchall()
 	#print(row)
 	'''
 	title   = "welcome"
 	if request.user.is_authenticated():
 		title = "Welcome %s" % (request.user)
 	context = {"title":title}
 	
 	return render(request,"home.html",context)


def show(request):
	c = connection.cursor()
 	c.execute("select * from EMPLOYEE")
 	row = c.fetchall()
 	context = {"table":row}
 	return render(request,"display.html",context)

@login_required
def administrator(request):
	if request.user.username == "Devang" and request.user.email == "Admin": 
		print "password :" , request.user.password
		context={}
		context["Name"] = "Devang"

		c = connection.cursor()
		c.execute("select * from EMPLOYEE")
		emp_data = c.fetchall()
		c.close()
		context["emp_data"] = emp_data
		context["emp_columns"] = ["Employee ID","Department ID","Name","Date of birth","Sex","Designation","Address"]

		c = connection.cursor()
		c.execute("select * from ARTIFACT")
		artifact_data = c.fetchall()
		c.close()
		context["artifact_data"] = artifact_data
		context["artifact_columns"] = ["Accessioon Number","Department ID","Title","Date acquired","Number of copies","Description","Artist ID"]

		c = connection.cursor()
		c.execute("select * from ARTIST")
		emp_data = c.fetchall()
		c.close()
		context["artist_data"] = emp_data
		context["artist_columns"] = ["Artist ID","Name","Nationality","Begin Date","End Date","Phone"]

		c = connection.cursor()
		c.execute("select * from DEPARTMENT")
		emp_data = c.fetchall()
		c.close()
		context["dept_data"] = emp_data
		context["dept_columns"] = ["Department ID","Name","Opening time","Closing time"]


		return render(request,"admin_dashboard.html", context)
	else :
		return HttpResponse("administrator is not logged in")

@login_required
def artist_reg(request):
	if request.user.username == "Devang" and request.user.email == "Admin": 
		context={}
		context["Name"] = "Devang"

		if request.method == "POST" :

			Firstname = request.POST.get("fname")
			Lastname = request.POST.get("lname")
			Name = Firstname + ' ' + Lastname
			Nationality = request.POST.get("nationality")
			Begin_date = request.POST.get("begindate")
			End_date = request.POST.get("enddate")
			Phone = request.POST.get("phone")
			if End_date=='' : End_date = '2100-12-31'

			context = {"fname":Firstname,"lname":Lastname,"begindate":Begin_date,"enddate":End_date,"nationality":Nationality,"phone":Phone}
			context["Name"] = "Devang"

			if not check_text(Firstname) :
				context["error"] = "Firstname can contain only lowercase/uppercase alphabets"
				return render(request,"reg_artist.html",context)
			if not check_text(Lastname) :
				context["error"] = "Lastname can contain only lowercase/uppercase alphabets"
				return render(request,"reg_artist.html",context)
			if not check_text(Nationality) :
				context["error"] = "Nationality can contain only lowercase/uppercase alphabets"
				return render(request,"reg_artist.html",context)
			if not check_dob(Begin_date) :
				context["error"] = "Begin date should be valid"
				return render(request,"reg_artist.html",context)
			if End_Date != '2100-12-31' and not check_dob(End_date) :
				context["error"] = "End date should be valid"
				return render(request,"reg_artist.html",context)
			if not check_number(Phone) :
				context["error"] = "Contact field can contain only digits(0-9)"
				return render(request,"reg_artist.html",context)
			if len(Phone)!=10 :
				context["error"] = "Contact should be of 10 digits"
				return render(request,"reg_artist.html",context)

			c = connection.cursor()
			c.execute("select * from ARTIST where Name=('%s')" % (Name))
			
			if c.rowcount>0:
				context["error"] = "Name already exists"
				return render(request,"reg_artist.html",context)
			c.close()
			c = connection.cursor()
			c.execute("Insert into ARTIST(Name,Nationality,Begin_date,End_date,Phone) values ('%s','%s','%s','%s','%s')" % (Name, Nationality,Begin_date,End_date,Phone))
			c.close()

			return HttpResponse("Artist record added suc")

		return render(request,"reg_artist.html", context)
	else :
		return HttpResponse("administrator is not logged in")

def get_dept_id(dept) :
	c = connection.cursor()
	c.execute("select Dept_ID from DEPARTMENT where Name = ('%s')" % (dept))
	row = c.fetchone()
	if row is not None :
		return row[0]
	else : 
		return -1

def get_artist_id(artist) :
	c = connection.cursor()
	c.execute("select Artist_ID from ARTIST where Name = ('%s')" % (artist))
	row = c.fetchone()
	if row is not None :
		return row[0]
	else : 
		return -1

@login_required
def artifact_reg(request):
	if request.user.username == "Devang" and request.user.email == "Admin": 
		context={}
		context["Name"] = "Devang"

		if request.method == "POST" :

			Accession_number = request.POST.get("accessionnumber")
			Department = request.POST.get("department")
			Artist = request.POST.get("artist")
			Title = request.POST.get("title")
			Date_acquired = request.POST.get("dateacquired")
			Number_of_copies = request.POST.get("numberofcopies")
			Description = request.POST.get("description")
			
			context={"an":Accession_number,"department":Department,"artist":Artist,"title":Title,"date":Date_acquired,"noc":Number_of_copies,"description":Description}
			context["Name"] = "Devang"

			if not check_dob(Date) : 
				context["error"] = "Date acquired must be valid and in correct format"
				return render(request,"reg_artifact.html",context)

			c = connection.cursor()
			c.execute("select Name from DEPARTMENT where Name=('%s')" % Department)
			if c.rowcount == 0:
				context["error"] = "Department does not exist"
				return render(request,"reg_artifact.html",context)
			c.close()
			Dept_ID = get_dept_id(Department)

			c = connection.cursor()
			c.execute("select Name from ARTIST where Name=('%s')" % Artist)
			if c.rowcount == 0:
				context["error"] = "Artist does not exist"
				return render(request,"reg_artifact.html",context)
			c.close()
			Artist_ID = get_artist_id(Artist)

			if int(Number_of_copies)<1:
				context["error"] = "Add atleast 1 copy"
				return render(request,"reg_artifact.html",context)
			if int(Number_of_copies)>10:
				context["error"] = "Maximum 10 copies of the Artifact ca be kept in the museum."
				return render(request,"reg_artifact.html",context)

			c = connection.cursor()
			c.execute("select * from ARTIFACT where Accession_number=('%s')" % Accession_number)
			if c.rowcount>0:
				context["error"] = "Accession Number already exists"
				return render(request,"reg_artifact.html",context)

			c = connection.cursor()
			c.execute("Insert into ARTIFACT values ('%s','%s','%s','%s','%s', '%s', '%s')" % (Accession_number, Dept_ID,Title,Date_acquired,Number_of_copies,Description,Artist_ID))
			c.close()	
			
			return HttpResponse("Artifact record added successfully")	

		return render(request,"reg_artifact.html", context)
	else :
		return HttpResponse("administrator is not logged in")

def get_emp_ID(name) :
	c = connection.cursor()
	c.execute("select Emp_ID from EMPLOYEE where Name = ('%s')" % name)
	row = c.fetchone()
	c.close()
	return row[0]

@login_required
def emp_reg(request):
	if request.user.username == "Devang" and request.user.email == "Admin": 
		context={}
		context["Name"] = "Devang"

		if request.method == "POST" :

			Firstname = request.POST.get("fname")
			Lastname = request.POST.get("lname")
			Name = Firstname + ' ' + Lastname
			Department = request.POST.get("department")
			Date_of_birth = request.POST.get("dateofbirth")
			Sex = request.POST.get("sex")
			Designation = request.POST.get("designation")
			Address = request.POST.get("address")
			Phone1 = request.POST.get("phone1")
			Phone2 = request.POST.get("phone2")
			context = {"fname":Firstname,"lname":Lastname,"department":Department,"dateofbirth":Date_of_birth,"sex":Sex,"designation":Designation,"address":Address,"phone1":Phone1,"phone2":Phone2}
			context["Name"] = "Devang"
			if not check_text(Firstname) :
				context["error"] = "Firstname can contain only lowercase/uppercase alphabets"
				return render(request,"reg_emp.html",context)
			if not check_text(Lastname): 
				context["error"] = "Lastname can contain only lowercase/uppercase alphabets"
				return render(request,"reg_emp.html",context)
			if not check_dob(Date_of_birth) :
				context["error"] = "Date of birth should be valid"
				return render(request,"reg_emp.html",context)
			if Sex not in ['M','F'] :
				context["error"] = "Sex can be either M or F"
				return render(request,"reg_emp.html",context)
			if not check_number(Phone1) :
				context["error"] = "Contact field can contain only digits(0-9)"
				return render(request,"reg_emp.html",context)
			if len(Phone1)!=10 :
				context["error"] = "Contact should be of 10 digits"
				return render(request,"reg_emp.html",context)
			if Phone2!='' and not check_number(Phone2) :
				context["error"] = "Contact field can contain only digits(0-9)"
				return render(request,"reg_emp.html",context)
			if Phone2!='' and  len(Phone2)!=10 :
				context["error"] = "Contact should be of 10 digits"
				return render(request,"reg_emp.html",context)

			c = connection.cursor()
			c.execute("select Name from DEPARTMENT where Name=('%s')" % Department)
			rows = c.fetchall()
			
			if c.rowcount == 0:
				context["error"] = "Department does not exist"
				return render(request,"reg_emp.html",context)
			c.close()
			Dept_ID = get_dept_id(Department)

			c = connection.cursor()
			c.execute("select * from EMPLOYEE where Name=('%s')" % Name)
			if c.rowcount>0:
				context["error"] = "Employee name already exists!!"
				return render(request,"reg_emp.html",context)

			c = connection.cursor()
			c.execute("Insert into EMPLOYEE(Dept_ID,Name,Date_of_birth,Sex,Designation,Address) values ('%s','%s','%s','%s','%s','%s')" % (Dept_ID,Name,Date_of_birth,Sex,Designation,Address))
			Emp_ID = get_emp_ID(Name)
			c.execute("Insert into EMPLOYEECONTACT values ('%s','%s')" % (Emp_ID,Phone1))
			if Phone2!='':
				c.execute("Insert into EMPLOYEECONTACT values ('%s','%s')" % (Emp_ID,Phone2))
			c.close()	
			
			return HttpResponse("New employee added successfully")

		return render(request,"reg_emp.html",context)
	else :
		return HttpResponse("administrator is not logged in")



@login_required
def department_reg(request):
	if request.user.username == "Devang" and request.user.email == "Admin": 
		context={}
		context["Name"] = "Devang"

		if request.method == "POST" :

			Name = request.POST.get("departmentname")
			Opening_time = request.POST.get("openingtime")
			Closing_time = request.POST.get("closingtime")
			context = {"department":Name,"openingtime":Opening_time,"closingtime":Closing_time}
			context["Name"] = "Devang"

			if not check_time(Opening_time) : 
				context["error"] = "Enter valid opening time"
				return render(request,"reg_dept.html",context)
			if not check_time(Closing_time) : 
				context["error"] = "Enter valid closing time"
				return render(request,"reg_dept.html",context)

			c = connection.cursor()
			c.execute("select * from DEPARTMENT where Name=('%s')" % (Name))
			if c.rowcount > 0:
				context["error"] = "Department name already exists!!"
				return render(request,"reg_dept.html",context)
			
			
			c = connection.cursor()
			c.execute("Insert into DEPARTMENT(Name,Opening_time,Closing_time) values ('%s','%s','%s')" % (Name, Opening_time,Closing_time))
			c.close()	
			
			return HttpResponse("New department added successfully")		

		return render(request,"reg_dept.html")
	else :
		return HttpResponse("administrator is not logged in")

@login_required
def visitorpage(request) :
	if request.user.username == "Devang" and request.user.email == "Admin": 
		return HttpResponse("Visitor is not logged in")
	else :
		context={}
		context["Name"] = request.user.username
		

		c = connection.cursor()
		c.execute("select Date, Type, Number_of_tickets, Feedback from TICKET where Visitor_ID = ('%s')" % (get_visitor_id(request.user.username)))
		table = c.fetchall()
		c.close()
		context["ticket_data"] = table
		context["ticket_columns"] = ['Date', 'Type of Ticket', 'Number of Tickets Booked', 'Feedback']

		return render(request,"visitor_dashboard.html",context)

def visitor_reg(request) :
	if request.method == "POST" :

		firstname = request.POST.get("fname")
		lastname = request.POST.get("lname")
		Name = firstname + ' ' + lastname
		Nationality = request.POST.get("nationality")
		Address = request.POST.get("address")
		Email = request.POST.get("email")
		Phone = request.POST.get("phone")

		context = {"fname":firstname,"lname":lastname,"nationality":Nationality,"address":Address,"email":Email,"phone":Phone}
		
		if not check_text(firstname) :
			context["error"] = "Firstname can contain only lowercase/uppercase alphabets"
			return render(request,"reg_visitor.html",context)
		if not check_text(lastname): 
			context["error"] = "Lastname can contain only lowercase/uppercase alphabets"
			return render(request,"reg_visitor.html",context)
		if not check_text(Nationality) :
			context["error"] = "Nationality can contain only lowercase/uppercase alphabets"
			return render(request,"reg_visitor.html",context)
		if not check_number(Phone) :
			context["error"] = "Contact field can contain only digits(0-9)"
			return render(request,"reg_visitor.html",context)
		if len(Phone)!=10 :
			context["error"] = "Contact should be of 10 digits"
			return render(request,"reg_visitor.html",context)
		c = connection.cursor()
		c.execute("select Email,Name from VISITOR")
		rows = c.fetchall()
		c.close()
		for row in rows : 
			if Name == row[1] : 
				context["error"] = "Name already registered"
				return render(request,"reg_visitor.html",context)
			if Email == row[0] : 
				context["error"] = "Email already registered"
				return render(request,"reg_visitor.html",context)

		c = connection.cursor()
		c.execute("Insert into VISITOR(Name,Nationality,Phone,Address,Email) values ('%s','%s','%s','%s','%s')" % (Name,Nationality,Phone,Address,Email))
		c.close()	
		c=connection.cursor()
		c.execute("Select Visitor_ID from VISITOR where Name=('%s')" % (Name))
		r = c.fetchone()
		c.close()
		return HttpResponse("Registration successfull, Username and Password is ('%s','%s')" % (Name,r[0]))

	return render(request,"reg_visitor.html")

def get_visitor_id(visitor) :
	c = connection.cursor()
	c.execute("select Visitor_ID from VISITOR where Name = ('%s')" % (visitor))
	row = c.fetchone()
	if row is not None :
		return row[0]
	else : 
		return -1
		

@login_required
def ticket_book(request) :
	if request.user.username == "Devang" and request.user.email == "Admin": 
		return HttpResponse("Visitor is not logged in")
	else :
		context={}
		context["Name"] = request.user.username

		if request.method == "POST" :

			date = request.POST.get("date")
			Number_of_tickets = request.POST.get("number")
			type1 = request.POST.get("type")
			Visitor_ID = get_visitor_id(request.user.username)
			context["date"] = date
			context["not"] = Number_of_tickets
			context["type"] = type1
			if int(Number_of_tickets)<1:
				context["error"] = "Book atleast 1 ticket"
				return render(request,"book_ticket.html",context)
			if int(Number_of_tickets)>10:
				context["error"] = "Maximum limit per user per date is 10"
				return render(request,"book_ticket.html",context)
			if not check_dob_fwd(date):
				context["error"] = "Enter a valid date"
				return render(request,"book_ticket.html",context)
			if type1 not in ['N','S'] :
				context["error"] = "Type must be either of 'N' or 'S'"
				return render(request,"book_ticket.html",context)
			# if type1=='N' :
			# 	if date in normal_dict and normal_dict[date] + Number_of_tickets > 20 : 
			# 		return HttpResponse("Normal tickets not available for this date. Try for special tickets or another date")
			# 	if date in normal_dict : normal_dict[date] += Number_of_tickets
			# 	else : normal_dict[date] = 1
			# else :
			# 	if date in special_dict and special_dict[date] + Number_of_tickets > 20 : 
			# 		return HttpResponse("Special tickets not available for this date. Try for normal tickets or another date")
			# 	if date in special_dict : special_dict[date] += Number_of_tickets
			# 	else : special_dict[date] = 1

			c = connection.cursor()
			try :
				c.execute("Insert into TICKET values ('%s','%s','%s','%s','')" % (Visitor_ID,date,type1,Number_of_tickets))
			except :
				print Visitor_ID
				return HttpResponse("You have already booked ('%s') tickets for this date" % (type1))
			c.close()	
			
			return HttpResponse("Booked tickets successfully")

		return render(request,"book_ticket.html",context)

@login_required
def feedback(request) :
	if request.user.username == "Devang" and request.user.email == "Admin": 
		return HttpResponse("Visitor is not logged in")
	else :
		context={}
		context["Name"] = request.user.username

		if request.method == "POST" :

			Date = request.POST.get("date")
			Type = request.POST.get("type")
			Feedback = request.POST.get("feedback")	
			context["date"] = Date
			context["type"] = Type
			context["feedback"] = feedback

			if Type not in ['N','S'] :
				context["error"] = "Type must be either of 'N' or 'S'"
				return render(request,"feedback.html",context)

			c = connection.cursor()
			try :
				c.execute("update TICKET set Feedback = ('%s') where Visitor_ID = ('%s') and Date = ('%s') and Type = ('%s')" % (Feedback , get_visitor_id(request.user.username) , Date , Type))
			except :
				return HttpResponse("No booked ticket found for provided date and type")
			c.close()			
			return HttpResponse("Feedback(s) added successfully")

		return render(request,"feedback.html",context)

@login_required
def visit_history(request) :
	if request.user.username == "Devang" and request.user.email == "Admin": 
		return HttpResponse("Visitor is not logged in")
	else :
		context={}
		context["Name"] = request.user.username

		c = connection.cursor()
		c.execute("select Date, Type, Number_of_tickets, Feedback from TICKET where Visitor_ID = ('%s')" % (get_visitor_id(request.user.username)))
		table = c.fetchall()
		c.close()
		context["table"] = table
		context["columns"] = ['Date', 'Type of Ticket', 'Number of Tickets Booked', 'Feedback']
		return render(request,"visit_history.html",context)

@login_required
def edit_profile(request) :
	if request.user.username == "Devang" and request.user.email == "Admin": 
		return HttpResponse("Visitor is not logged in")
	else :
		context={}
		context["Name"] = request.user.username
		Name = request.user.username
		context["fname"] = Name.split(' ')[0]
		context["lname"] = Name.split(' ')[1]
		Visitor_ID = get_visitor_id(Name)

		if request.method == "POST" :

			Nationality = request.POST.get("nationality")
			Phone = request.POST.get("phone")
			Address = request.POST.get("address")
			Email = request.POST.get("email")

			context["nationality"] = Nationality
			context["phone"] = Phone
			context["address"] = Address
			context["email"] = Email

			if not check_text(Nationality) :
				context["error"] = "Nationality can only contain alphabets"
				return render(request,"visitor_profile.html",context)
			if len(Phone)!=10 :
				context["error"] = "Contact Number should be of exactly 10 digits"
				return render(request,"visitor_profile.html",context)
			

			c = connection.cursor()
			c.execute("delete from VISITOR where Visitor_ID = ('%s')" % Visitor_ID)
			c.close()
			c = connection.cursor()
			c.execute("insert into VISITOR values ('%s','%s','%s','%s','%s','%s')" % (Visitor_ID,Name,Nationality,Phone,Address,Email))
			c.close()			
			return HttpResponse("Profile updated successfully")

		c = connection.cursor()
		c.execute("select Nationality,Phone,Address,Email from VISITOR where Visitor_ID = ('%s')" % (Visitor_ID))
		row = c.fetchone()
		c.close()

		context["nationality"] = row[0]
		context["phone"] = row[1]
		context["address"] = row[2]
		context["email"] = row[3]

		return render(request,"visitor_profile.html", context)

@login_required
def user_logout(request):
	logout(request)
	return HttpResponseRedirect('/loginform/')

def artifact(request):
	c = connection.cursor()
 	c.execute("select Title,Date_acquired,Number_of_copies,Description from ARTIFACT")
 	row = c.fetchall()
 	context = {"table":row}
 	columns = ['Title','Date_acquired','Number_of_copies','Description']
 	context["columns"] = columns
 	return render(request,"display.html",context)

def artist_artifact(request):

	data = []
	c = connection.cursor()
	c.execute("select Artist_ID,Name from ARTIST")
	artists = c.fetchall()
	artist_names = []
	c.close()
	for artist in artists :
		c = connection.cursor()
		c.execute("select Title,Number_of_copies,Description from ARTIFACT where Artist_ID = ('%s')" % (artist[0]))
		table = c.fetchall()
		if c.rowcount==0 :
			c.close()
			continue
		c.close()
		data.append(table)
		artist_names.append(artist[1])
	columns= ['Title','Number_of_copies','Description']
	result = zip(data , artist_names)
	context = {"zipped":result,"columns":columns}
	return render(request,"display_artists.html",context)

def department_artifact(request):

	data = []
	c = connection.cursor()
	c.execute("select Dept_ID,Name from DEPARTMENT")
	departments = c.fetchall()
	department_names = []
	c.close()
	for department in departments :
		c = connection.cursor()
		c.execute("select Title,Number_of_copies,Description from ARTIFACT where Dept_ID = ('%s')" % (department[0]))
		table = c.fetchall()
		if c.rowcount==0 :
			c.close()
			continue
		c.close()
		data.append(table)
		department_names.append(department[1])
	columns= ['Title','Number_of_copies','Description']
	result = zip(data , department_names)
	context = {"zipped":result,"columns":columns}
	return render(request,"display_departments.html",context)



