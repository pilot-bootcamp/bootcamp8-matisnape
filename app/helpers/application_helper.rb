module ApplicationHelper
  def parking_address(parking)
    if parking.present?
      link_to parking.address.display_full_address, parking_path(parking)
    else
      "Deleted parking"
    end
  end
end
