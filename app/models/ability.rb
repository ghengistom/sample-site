class Ability
  include CanCan::Ability

  def initialize(user, remote_ip)
    # Define abilities for the passed in user here.

    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    end

    if user.qa?
      can :show, :admin
      can :manage, Snippet
      can :manage, Attachment
      can :read, Example
      # can :manage, Example, department: 'qa'
    end

    if user.engineering?
      can :read, Example
      # can :manage, Example, department: 'engineering'
    end

    if user.support?
      can :read, Example
      # can :manage, Example, department: 'support'
    end

    can :read, Example, status: ['active', 'in progress']
    can :read, :login if ["198.217.120.88", "71.195.213.101", "24.250.82.108", "127.0.0.1", "10.0.0.1"].include?(remote_ip)
  end
end
