require "maxmind/geoip2"

module UsersHelper
  def user_status(user)
    user.active? ? "啟用中" : "停用中"
  end

  def user_status_color(user)
    user.active? ? "" : "text-rose-500"
  end

  def user_level(user)
    if user.admin?
      "{管理組長}"
    else
      user.premium? ? "{小組長}" : "{組員}"
    end
  end

  def user_level_color(user)
    if user.admin?
      "text-rose-500 font-bold"
    else
      user.premium? ? "text-indigo-500 font-bold" : "text-gray-800"
    end
  end

  def created_by_leader(user)
    if user.created_by_user
      user.created_by_user.username
    else
      ""
    end
  end

  def ip_to_city(ip)
    # This creates the Reader object which should be reused across lookups.
    if ip == "127.0.0.1" || ip == "::1" || ip == "" || ip == nil || ip == "localhost" || ip == []
      return "開發用ip"
    end
    reader = MaxMind::GeoIP2::Reader.new(database: "#{Rails.root.join('lib')}/GeoLite2-City.mmdb")
    record = reader.city(ip)
    record.city.name
  end

end
