module OthersCertificatesHelper

  def cer_label(c_type)
    case c_type
      when 'unmarried'
        'অবিবাহিত সনদের আবেদন'
      when 'no_remarried'
        'পুনঃ বিবাহ না হওয়ার সনদের আবেদন'
      when 'rename'
        'একি  নামের প্রত্যয়ন পত্রের আবেদন'
      when 'hindu'
        'সনাতন ধর্ম অবলম্বী সনদের আবেদন'
      when 'landless'
        'ভূমিহীন সনদের আবেদন'
      when 'annual_income'
        'বার্ষিক আয়ের প্রত্যয়ন পত্রের আবেদন'
      when 'impirement'
        'প্রকৃত বাঁক এবং স্রবণ প্রতিবন্ধী সনদের আবেদন'
      when 'permission'
        'অনুমতি পত্রের আবেদন'
      when 'prottoyon'
        'প্রত্যয়ন পত্রের আবেদন'
    end
  end


  def cer_label_type(c_type)
    case c_type
      when 'unmarried'
        'অবিবাহিত'
      when 'no_remarried'
        'পুনঃ বিবাহ না'
      when 'rename'
        'একি নামের প্রত্যয়ন'
      when 'hindu'
        'সনাতন ধর্ম'
      when 'landless'
        'ভূমিহীন'
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
