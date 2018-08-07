module OthersCertificatesHelper

  def cer_label(c_type)
    case c_type
      when 'unmarried'
        'অবিবাহিত সনদের আবেদন'
      when 'married'
        'বিবাহিত সনদের আবেদন'
      when 'no_remarried'
        'পুনঃ বিবাহ না হওয়ার সনদের আবেদন'
      when 'unemployed'
        'বেকারত্ব সনদের আবেদন'
      when 'non_solvent'
        'আর্থিক অসচ্ছলতার সনদ'
      when 'rename'
        'একি  নামের প্রত্যয়ন পত্রের আবেদন'
      when 'only_widow'
        'একমাত্র বৈধ বিধবা স্ত্রীর সনদপত্র'
      when 'landless'
        'ভূমিহীন সনদের আবেদন'
      when 'annual_income'
        'বার্ষিক আয়ের প্রত্যয়ন পত্রের আবেদন'
      when 'permanent_citizen'
        'স্থায়ী বাসিন্দার সনদ'
      when 'same_name'
        'দুই নামে একই ব্যক্তির সনদপত্র'
      when 'freedom_fighter'
        'মুক্তিযোদ্ধা সনদের আবেদন'
      when 'income_monthly'
        'মাসিক আয়ের সনদপত্র'
      when 'income_yearly'
        'বাৎসরিক আয়ের সনদপত্র'
      when 'relationship'
        'সম্পর্কের সনদপত্র'
      when 'orphan'
        'এতিম সনদপত্র'
      when 'address_change'
        'ঠিকানা পরিবর্তনের প্রত্যয়ন পত্র'
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
      when 'unemployed'
        'বেকারত্ব'
      when 'non_solvent'
        'আর্থিক অসচ্ছল'
      when 'rename'
        'একি নামের প্রত্যয়ন'
      when 'only_widow'
        'বৈধ বিধবা স্ত্রী'
      when 'annual_income'
        'বার্ষিক আয়ের প্রত্যয়ন'
      when 'permanent_citizen'
        'স্থায়ী বাসিন্দা'
      when 'same_name'
        'দুই নামে একই'
      when 'freedom_fighter'
        'মুক্তিযোদ্ধা'
      when 'income_yearly'
        'বাৎসরিক আয়'
      when 'income_monthly'
        'মাসিক আয়'
      when 'relationship'
        'সম্পর্ক'
      when 'orphan'
        'এতিম'
      when 'address_change'
        'ঠিকানা পরিবর্তন'
    end
  end

  def cer_husband_wife(cb)
    return '' if cb.maritial_status.unmarried? || cb.maritial_status.married? || cb.other?
    return 'স্বামীর' if cb.female?
    return 'স্ত্রীর' if cb.male?
    return 'সঙ্গীর' if cb.other?
  end

  def cer_maritial_state(cb)
    return '' if cb.maritial_status.unmarried? || cb.maritial_status.married? || cb.other?
    return 'মৃত্যুর পর' if cb.maritial_status.widow?
    return 'সাথে বিচ্ছেদের পর' if cb.maritial_status.divorced?
  end

  def who(work_info)
    return work_info.for_whom_others if work_info.for_whom.other?
    work_info.for_whom.who_in_bangla
  end

  def income_whom(work_info)
    return '' if work_info.blank?
    if work_info.for_whom.own?
      return "তিনি একজন #{work_info.work_title}"
    end

    if work_info.for_whom.other?
      who = work_info.for_whom_others
    else
      who = work_info.for_whom.who_in_bangla
    end

    return "তাহার #{who} একজন #{work_info.work_title}"
  end

  def income_type(work_info)
    return String.new if work_info.blank?

    case work_info.income_type
      when 'income_monthly'
        'মাসিক আয়ের সনদপত্র'
      when 'income_yearly'
        'বাৎসরিক আয়ের সনদপত্র'
    end
  end

  def income_money(work_info)
    return '' if work_info.blank?

    type = String.new
    case work_info.income_type
      when 'income_monthly'
        type = 'মাসিক'
      when 'income_yearly'
        type = 'বাৎসরিক'
    end

    if work_info.for_whom.own?
      return "তাহার #{type} আয় #{bangla_number(number_with_delimiter(work_info.annual_income))}( #{work_info.income_in_bangla} ) টাকা"
    end

    return "তাহার #{who(work_info)}র #{type} আয় #{bangla_number(number_with_delimiter(work_info.annual_income))} (#{work_info.income_in_bangla}) টাকা"
  end

end
