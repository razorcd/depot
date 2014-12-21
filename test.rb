class Big

  private

  def privBig
    puts 'privBig'
  end
end

class Small < Big

  def pubSmall
    privBig
    x = Big.new
    x.privBig
  end
end

a = Small.new
a.pubSmall
