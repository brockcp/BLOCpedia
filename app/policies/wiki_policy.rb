class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

   def index?
     true
   end

  def admin_list?
    user.admin?
  end

   def create?
     user.present?
   end

   def update?
     user.present? #CURRENT
     #user.present? && (user.admin? == wiki.user) #IF-BOTH BUTTONS DISAPPEAR
     #user.present? || user.admin? || user.present?
     #user.admin? or not wiki.published?
   end

   def destroy?
     (user.present? && user.admin?) #CURRENT
     #user.admin?
     #user.present? && (user.admin? == wiki.user) #DELETE BUTTON DISAPPEARS
     #user.admin? || wiki.user
     #user.admin? or not wiki.published?
     #user.present? #IF-BOTH BUTTONS APPEAR FOR ALL
   end


end
