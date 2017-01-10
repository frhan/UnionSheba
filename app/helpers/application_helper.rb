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
    return String.new  unless date.present?
    bangla_number(date.day.to_s) << ' '<< bangla_month(date.month)<< ' ' << bangla_number(date.year.to_s)
  end

  def bangla_date(date)
    return String.new  unless date.present?
    bangla_number(date.day.to_s) << '/' << bangla_number(date.month.to_s) << '/' << bangla_number(date.year.to_s)
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
        month =  'মে'
      when 6
        month = 'জুন'
      when 7
        month = 'জুলাই'
      when 8
        month = 'অগাস্ট'
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
end
