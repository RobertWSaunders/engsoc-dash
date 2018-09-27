# frozen_string_literal: true

module UserHelper
  def superadmin?(user)
    if user.role == 'superadmin'
      return true
    elsif user.jobs.any?
      user.jobs.each do |jb|
        return true if jb.role == 'admin'
      end
    end

    false
  end

  def managed_orgs(user)
    if user.jobs.any?
      orgs = []
      user.jobs.each do |jb|
        if jb.role == 'management' || jb.role == 'admin'
          orgs.push(jb.organization)
        end
      end
      # orgs = Organization.joins(:jobs, :).where(:jobs => { :role => "management" })
    else
      return []
    end
    Organization.where(id: orgs.map(&:id))
  end
end
