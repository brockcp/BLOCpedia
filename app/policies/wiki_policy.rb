class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

   def create?
     user.present?
   end

   def update?
     user.present?

   end

   def destroy?
     user.present?
     #(user.present? && user.admin?) #premium couldnt delete own wiki with this
   end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
        wikis = []
        if user.nil?  #IF NIL NECESSARY FOR GUEST TO SEE INDEX
          all_wikis = scope.all
          wikis = []
          all_wikis.each do |wiki|
            if !wiki.private?
              wikis << wiki
            end
          end

        elsif user.role == 'admin'
            wikis = scope.all # ADMIN - SHOW ALL WIKIS

        elsif user.role == 'premium'
            all_wikis = scope.all
            all_wikis.each do |wiki|
                if !wiki.private? || wiki.user == user || wiki.collaborating_users.include?(user)
                    wikis << wiki #PREMIUM - SHOW PUBLIC, OWN PRIVATE, & COLLABORATING WIKIS
                end
            end

        else # STANDARD
            all_wikis = scope.all
            wikis = []
            all_wikis.each do |wiki|
                if !wiki.private? || wiki.collaborating_users.include?(user)
                    wikis << wiki #STANDARD - PUBLIC & COLLABORATING WIKIS
                end
            end
        end
        wikis # RETURN NEW ARRAY
    end
end
end
