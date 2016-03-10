module ApplicationHelper
  def parking_address(parking)
    if parking.present?
      link_to parking.address.display_full_address, parking_path(parking)
    else
      t('parkings.deleted')
    end
  end

  def mapping
    {
    error: :danger,
    notice: :info,
    success: :success
    }.with_indifferent_access
  end
end
