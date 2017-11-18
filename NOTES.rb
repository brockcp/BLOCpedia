APPLICATIONCONTROLLER
#when :show removed -> click on wiki and must login.
#when :index removed -> home disappears

if wiki is private is current user and current user is wiki user!
OR the wiki is private and  current user!


removed 'markdown' from wiki index view


Pundit
WikisController
       cho    real    brock
skip    x               x
new     x               x
create  x       x       x
edit    x               x
update  x               O
destroy x               O
these above are for authorize @wiki

wiki-policy
destroy user-pr&& user.admin
