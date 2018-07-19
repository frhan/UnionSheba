module OthersCertificatesHelper

  def cer_label(c_type)
    case c_type
      when 'unmarried'
        'অবিবাহিত সনদ'
      when 'no_remarried'
        'পুনঃ বিবাহ না হওয়ার সনদ'
      when 'rename'
        'একি  নামের প্রত্যয়ন পত্র'
      when 'hindu'
        'সনাতন ধর্ম অবলম্বী'
      when 'landless'
        'ভূমিহীন সনদ'
      when 'annual_income'
        'বার্ষিক আয়ের প্রত্যয়ন'
      when 'impirement'
        'প্রকৃত বাঁক এবং স্রবণ প্রতিবন্ধী'
      when 'permission'
        'অনুমতি পত্র'
      when 'prottoyon'
        'প্রত্যয়ন পত্র'
    end
  end
end
