class Ability
  include CanCan::Ability

  # Good resources for cancancan gem used for authorization:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  # https://github.com/CanCanCommunity/cancancan/wiki/Action-Aliases
  # https://github.com/CanCanCommunity/cancancan/wiki/Custom-Actions

  # there are four roles a user can have concurrently see below:
  # Super Admin: highest level of admins, can perform any operation on any entity
  # Admin: provides pure admin power, can perform any operation on any entity except users
  # Managment: provides more admin power but limited, can submit jobs for approval
  # Student: most basic user level, intended for the basic function

  #define the actions users can perform based on role
  def initialize(user)
    # retreive the user
    user ||= User.new
    # super admins can perform any action on any object
    if user.superadmin_role?
      can :manage, :all
    # admins can perform any action on specified objects
  elsif user.admin_role?
      can :manage, [Job,JobPosting]
    elses
      can :read, :all
    end
  end
end
