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
  def status_label_organization(organization)
    case organization.status
      when "waiting_approval"
        content_tag(:div, 'pending approval', class: 'label label-warning')
      when "active"
        content_tag(:div, 'active', class: 'label label-success')
      else
        content_tag(:div, 'archived', class: 'label label-danger')
    end
  end

  # content for the job application status labels
  def status_label_application(application)
    case application.status
      when "draft"
        content_tag(:div, 'draft', class: 'label label-warning')
      when "submitted"
        content_tag(:div, 'submitted', class: 'label label-primary')
      when "interview_scheduled"
        content_tag(:div, 'interview scheduled', class: 'label label-info')
      when "hired"
        content_tag(:div, 'hired', class: 'label label-success')
      else
        content_tag(:div, 'not chosen', class: 'label label-inverse')
    end
  end

  # content for the job application status labels
  def role_label_organization(user)
    case application.status
      when "draft"
        content_tag(:div, 'draft', class: 'label label-warning')
      when "submitted"
        content_tag(:div, 'submitted', class: 'label label-primary')
      when "interview_scheduled"
        content_tag(:div, 'interview scheduled', class: 'label label-info')
      when "hired"
        content_tag(:div, 'hired', class: 'label label-success')
      else
        content_tag(:div, 'not chosen', class: 'label label-inverse')
    end
  end


end
