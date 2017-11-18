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

   end

   def destroy?
     (user.present? && user.admin?)
   end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
        wikis = []
        if user.nil?  #CANT ACCESS INDEX FOR GUEST WITHOUT THIS
          wikis = scope.all

        elsif user.role == 'admin'
            wikis = scope.all # if user admin, show all wikis

        elsif user.role == 'premium'
            all_wikis = scope.all
            all_wikis.each do |wiki|
                if !wiki.private? || wiki.user == user || wiki.collaborators.include?(user) #HELP-SHOULD BE PUBLIC -> PREMIUM CANT SEE INDEX-THROWS ERROR
                    wikis << wiki # if premium, only show public wikis, private wikis they created, or private wikis they are collaborator
                end
            end

        else # standard user
            all_wikis = scope.all
            wikis = []
            all_wikis.each do |wiki|
                if !wiki.public? || wiki.collaborators.include?(user)
                    wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
                end
            end
        end
        wikis # return the wikis array we've built up
    end
end
end
