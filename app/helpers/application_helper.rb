module ApplicationHelper

  def is_numeric(number)
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
        when '১'
          bn << c
        when '২'
          bn << c
        when '৩'
          bn << c
        when '৪'
          bn << c
        when '৫'
          bn << c
        when '৬'
          bn << c
        when '৭'
          bn << c
        when '৮'
          bn << c
        when '৯'
          bn << c
        when '০'
          bn << c
        else
          return -1
      end
    end
    bn
  end

end
