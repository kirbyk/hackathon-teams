class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user
 
    if user.role? :super_admin
      can :manage, :all
    else
      can :read, :all
    end
    # elsif user.role? :admin
    #   can :manage, :all
    # elsif user.role? :sponsor

    # elsif user.role? :representative
    #   can :read, [TODO STUFF]
    #   # manage products, assets he owns
    #   can :manage, Product do |product|
    #     product.try(:owner) == user
    #   end
    #   can :manage, Asset do |asset|
    #     asset.assetable.try(:owner) == user
    #   end
    # end
  end
end
