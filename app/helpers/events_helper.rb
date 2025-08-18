module EventsHelper
  def lock_image_for(privacystatus)
    privacy_icons = { false => 'not-locked.svg', true => 'locked.svg' }
    image_tag(privacy_icons[privacystatus], class: 'privacy-icon')
  end
end
