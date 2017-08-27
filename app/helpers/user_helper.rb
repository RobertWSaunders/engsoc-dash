module UserHelper

  def admin?(user)
    if user.role == "superadmin"
      return true
    elsif user.jobs.any?
      user.jobs.each do |jb|
        if jb.role == "admin"
          return true
        end
      end
    end
    return false
  end

  def managed_orgs(user)
    if user.jobs.any?
      orgs = []
      user.jobs.each do |jb|
        if jb.role == "management"
          orgs.push(jb.organization)
        end
      end
      # orgs = Organization.joins(:jobs, :).where(:jobs => { :role => "management" })
    else
      return []
    end
    return Organization.where(id: orgs.map(&:id))
  end

end
