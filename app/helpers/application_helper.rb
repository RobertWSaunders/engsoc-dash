module ApplicationHelper

  # content for the job posting status labels
  def status_label(posting)
    case posting.status
      when "waiting_approval"
        content_tag(:div, 'pending approval', class: 'label label-warning')
      when "draft"
        content_tag(:div, 'draft', class: 'label label-warning')
      when "open"
        content_tag(:div, 'open', class: 'label label-success')
      when "interviews_pending"
        content_tag(:div, 'interviews pending', class: 'label label-warning')
      when "interviews_scheduled"
        content_tag(:div, 'interviews scheduled', class: 'label label-info')
      else
        content_tag(:div, 'closed', class: 'label label-danger')
    end
  end

  # content for the organization status labels
  def status_label(organization)
    case organization.status
      when "waiting_approval"
        content_tag(:div, 'pending approval', class: 'label label-warning')
      when "active"
        content_tag(:div, 'active', class: 'label label-success')
      else
        content_tag(:div, 'archived', class: 'label label-danger')
    end
  end

end
