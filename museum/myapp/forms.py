from django import forms

class LoginForm(forms.Form):
	fullname = forms.CharField()
	password = forms.CharField()
	

	# def clean_fullname(self):
	# 	fullname = self.cleaned_data.get('fullname')
	# 	#validate here

	# 	return fullname

	# def clean_password(self):
	# 	password = self.cleaned_data.get('password')
	# 	#validate here

	# 	return password

		
