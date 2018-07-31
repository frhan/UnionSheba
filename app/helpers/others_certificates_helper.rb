module OthersCertificatesHelper

  def cer_label(c_type)
    case c_type
      when 'unmarried'
        'অবিবাহিত সনদের আবেদন'
      when 'married'
        'বিবাহিত সনদের আবেদন'
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
        'অবিবাহিত সনদ'
      when 'married'
        'বিবাহিত সনদ'
      when 'landless'
        'ভূমিহীন'
      when 'no_remarried'
        'পুনঃ বিবাহ না'
      when 'rename'
        'একি নামের প্রত্যয়ন'
      when 'hindu'
        'সনাতন ধর্ম'
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

  def cer_husband_wife(cb)
    return '' if cb.maritial_status.unmarried? ||  cb.maritial_status.married? || cb.other?
    return 'স্বামীর' if cb.female?
    return 'স্ত্রীর' if cb.male?
    return 'সঙ্গীর' if cb.other?
  end

  def cer_maritial_state(cb)
    return '' if cb.maritial_status.unmarried? ||  cb.maritial_status.married? || cb.other?
    return 'মৃত্যুর পর' if cb.maritial_status.widow?
    return 'সাথে বিচ্ছেদের পর' if cb.maritial_status.divorced?
  end

end
