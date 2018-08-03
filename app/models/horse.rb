class Horse < ApplicationRecord

  def father
    Horse.find(father_id)
  end

  def mother
    Horse.find(mother_id)
  end

  def g_father
    Horse.find(g_father_id)
  end

  def brothers
    Horse.where(mother_id: mother_id)
  end

  def cousins
    Horse.where(g_father_id: g_father_id)
  end

end
