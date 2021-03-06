module ApplicationHelper

  def is_numeric(number)
    return false unless number.present?
    number = number.strip
    number.each_char do |c|
      case c
        when '1'
        when '2'
        when '3'
        when '4'
        when '5'
        when '6'
        when '7'
        when '8'
        when '9'
        when '0'
        when '১'
        when '২'
        when '৩'
        when '৪'
        when '৫'
        when '৬'
        when '৭'
        when '৮'
        when '৯'
        when '০'
        else
          return false
      end
    end

    true
  end

  def bangla_number(number)
    bn = String.new
    return bn<<'-' unless number.present?

    number = number.strip
    number.each_char do |c|
      case c
        when '1'
          bn << '১'
        when '2'
          bn << '২'
        when '3'
          bn << '৩'
        when '4'
          bn << '৪'
        when '5'
          bn << '৫'
        when '6'
          bn << '৬'
        when '7'
          bn << '৭'
        when '8'
          bn << '৮'
        when '9'
          bn << '৯'
        when '0'
          bn << '০'
        else
          bn << c
      end
    end
    bn
  end

  def english_number(number)
    bn = String.new
    return bn<<'-' unless number.present?
    number = number.strip
    number.each_char do |c|
      case c
        when '১'
          bn << '1'
        when '২'
          bn << '2'
        when '৩'
          bn << '3'
        when '৪'
          bn << '4'
        when '৫'
          bn << '5'
        when '৬'
          bn << '6'
        when '৭'
          bn << '7'
        when '৮'
          bn << '8'
        when '৯'
          bn << '9'
        when '০'
          bn << '10'
        else
          bn << c
      end
    end
    bn
  end

  def bangla_full_date(date)
    return String.new unless date.present?
    bangla_number(date.day.to_s) << ' '<< bangla_month(date.month)<< ' ' << bangla_number(date.year.to_s)
  end

  def bangla_date(date)
    return String.new unless date.present?
    bangla_number(date.day.to_s) << '/' << bangla_number(date.month.to_s) << '/' << bangla_number(date.year.to_s)
  end

  def bangla_time(date)
    return String.new unless date.present?
    #bangla_number(date.day.to_s) << '/' << bangla_number(date.month.to_s) << '/' << bangla_number(date.year.to_s)
    bangla_number date.strftime("%I:%M:%S %p")
  end

  def bangla_month(month_no)

    case month_no
      when 1
        month = 'জানুয়ারী'
      when 2
        month = 'ফেব্রুয়ারী'
      when 3
        month = 'মার্চ'
      when 4
        month = 'এপ্রিল'
      when 5
        month = 'মে'
      when 6
        month = 'জুন'
      when 7
        month = 'জুলাই'
      when 8
        month = 'আগস্ট'
      when 9
        month = 'সেপ্টেম্বর'
      when 10
        month = 'অক্টোবর'
      when 11
        month = 'নভেম্বর'
      when 12
        month = 'ডিসেম্বর'
    end
    month
  end

  def license_fiscal_year
    bangla_number(2015.to_s)
  end

  def current_timestamp
    Time.now.strftime('%Y%m%d%H%M%S%L')
  end

  def current_year_month_day
    Time.now.strftime('%Y%m%d')
  end

  def current_year
    Time.now.strftime('%Y')
  end

  def pdf_file_name(prefix)
    prefix << current_timestamp.to_s
  end

  def citizen_file_name(citizen)
    pdf_file_name 'citizen_certificate_' << citizen.union_code
  end

  def formatted_date_time(date_time)
    date_time.strftime('%d-%m-%Y') if date_time.present?
  end

  def get_type
    return params[:collections][:type] if params[:collections].present?
  end

  def get_cat_type
    return params[:collections][:category_id] if params[:category_id].present?
  end

  def collection_money_type_bangla
    return 'দৈনিক আদায় বিবরণী' unless (params[:collections].present? && params[:collections][:type].present?)
    return 'দৈনিক আদায় বিবরণী' if params[:collections][:type] == 'all'
    return 'ট্যাক্স ও রেট আদায় বিবরণী' if params[:collections][:type] == 'TaxOrRateCollection'
    return 'ট্রেড লাইসেন্স ফি আদায় বিবরণী' if params[:collections][:type] == 'TradeLicense'
    return 'বিবিধ আদায় বিবরণী' if params[:collections][:type] == 'OthersCollection'
  end

  def current_fiscal_year_bangla
    now = Time.now
    year = now.year
    year = now.year - 1 if now.month < 7 #if fiscal year less than june
    bangla_number(year.to_s) << '-'<< bangla_number((year + 1).to_s)
  end

  def fiscal_year_bangla(year)
    bangla_number(year.to_s) << '-'<< bangla_number((year + 1).to_s)
  end

  def cfiscal_year(day)
    year = day.year
    year = day.year - 1 if day.month < 7 #if fiscal year less than june
    year
  end

  def current_fiscal_year
    now = Time.now
    year = now.year
    year = now.year - 1 if now.month < 7 #if fiscal year less than june
    year
  end

  def wicked_pdf_image_tag_for_public(img, options={})
    if img[0] == "/"
      new_image = img.slice(1..-1)
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else
      image_tag img
    end
  end

  def current_lang
    #return 'en' if params[:lang] == 'en'
    'bn'
  end

  def permanent_address?(address)
    return true if address.permanent_address?
    false
  end

  def address_type(address)
    return "বর্তমান ঠিকানা" if address.present_address?
    return "স্থায়ী ঠিকানা" if address.permanent_address?
    String.new
  end

  def address_type_change(address)
    return "পুরাতন ঠিকানা" if address.present_address?
    return "নতুন ঠিকানা" if address.permanent_address?
    String.new
  end

  def should_show_spouse?
    return false if !@c_type.present?
    return true if @c_type == 'no_remarried'
    return true if @c_type == 'married'
    return true if @c_type == 'only_widow'
    return false
  end

  def should_show_nick_name?
    return true if @c_type == 'same_name'
    return false
  end

  def should_show_spouse_name?(certificate)
    certificate.citizen_basic.female? && certificate.basic_information.spouse_name.present?
  end

  def should_show_freedom_fighter?(c_type)
    c_type =='freedom_fighter'
  end

  def should_show_work_info?(c_type)
    c_type =='income_yearly' || c_type =='income_monthly'
  end

  def should_show_relationship?(c_type)
    c_type =='relationship'
  end

  def relation(relationship)
    lat = "আমার জানামতে, তিনি #{relationship.person_title} #{relationship.to_whom} এর #{relationship.relation}"
    lat << " অর্থাৎ সম্পর্কে #{relationship.relation_type}" if relationship.relation_type.present?
    lat << ' ।'
  end

  def from_date
    return DateTime.parse(params[:start_date]) if params[:start_date].present?
    Date.today
  end

  def to_date
    return DateTime.parse(params[:end_date]) if params[:end_date].present?
    Date.today
  end

  def first_day_fiscal_year
    now = Time.now
    year = now.year
    year = now.year - 1 if now.month < 7 #if fiscal year less than june
    DateTime.parse("#{year}-07-01")
  end

  def last_day_fiscal_year
    now = Time.now
    year = now.year
    year = year + 1 if now.month > 7 #if fiscal year less than june
    DateTime.parse("#{year}-06-30")
  end

  def fday_fiscal_year(day)
    year = day.year
    year = day.year - 1 if day.month < 7 #if fiscal year less than june
    DateTime.parse("#{year}-07-01")
  end

  def lday_fiscal_year(day)
    year = day.year
    year = year + 1 if day.month > 7 #if fiscal year less than june
    DateTime.parse("#{year}-06-30")
  end

end
