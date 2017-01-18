"""museum URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""

from django.conf.urls import url
from django.contrib import admin
from myapp.views import *

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$', index, name='index'),
    url(r'^home/',home,name='home'),
    url(r'^show/', show, name='show'),
    url(r'^loginform/',loginform, name='loginform'),
    url(r'^administrator/',administrator, name='administrator'),
    url(r'^artist_reg/', artist_reg, name='artist_reg'),
    url(r'^emp_reg/', emp_reg, name='emp_reg'),
    url(r'^artifact_reg/', artifact_reg, name='artifact_reg'),
    url(r'^department_reg/', department_reg, name='department_reg'),
    url(r'^user_logout/', user_logout, name='user_logout'),
    url(r'^visitorpage/',visitorpage, name='visitorpage'),
    url(r'^visitor_reg/', visitor_reg, name='visitor_reg'),
    url(r'^ticket_book/', ticket_book, name='ticket_book'),
    url(r'^visit_history/', visit_history, name='visit_historyS'),
    url(r'^feedback/', feedback, name='feedback'),
    url(r'^artifact/', artifact, name='artifact'),
    url(r'^artist_artifact/', artist_artifact, name='artist_artifact'),
    url(r'^department_artifact/', department_artifact, name='department_artifact'),
    url(r'^edit_profile/', edit_profile, name='edit_profile'),
]
