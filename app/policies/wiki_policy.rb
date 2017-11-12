class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end


   def index?
     true
   end

   def create?
     user.present?
   end

   def update?
     user.present?
     #user.present? && (user.admin? == wiki.user) #IF-BOTH BUTTONS DISAPPEAR
   end

   def destroy?
     #user.present? #IF-BOTH BUTTONS APPEAR FOR ALL
     user.present? && (user.admin? == wiki.user)
   end


end
