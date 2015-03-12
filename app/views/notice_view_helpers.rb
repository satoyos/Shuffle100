class NoticeLabelHelpers < MK::UIViewHelpers
  targets NoticeLabel

  def move_up_half_height
    f = target.frame
    target.frame =
        CGRectMake(f.origin.x,
                   f.origin.y - f.size.height / 2,
                   f.size.width,
                   f.size.height
        )
  end
end