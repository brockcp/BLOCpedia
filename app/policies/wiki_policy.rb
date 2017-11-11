class WikiPolicy < ApplicationPolicy

 attr_reader :user, :wiki

 def initialize(user, wiki)
   @user = user
   @wiki = wiki
 end

 def destroy?
   user.admin? or user == wiki.user
 end

 def update?
   user.admin? or user == wiki.user
 end

end
