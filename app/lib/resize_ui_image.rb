# transported from code in Objective-C on ...
# http://stackoverflow.com/questions/6141298/how-to-scale-down-a-uiimage-and-make-it-crispy-sharp-at-the-same-time-instead

module ResizeUIImage
  module_function

  def resizeImage(image, newSize:newSize)
    newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height))
    imageRef = image.CGImage
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
    context = UIGraphicsGetCurrentContext()

    # Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, KCGInterpolationHigh)
    flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)

    CGContextConcatCTM(context, flipVertical)
    # Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef)

    # Get the resized image from the context and a UIImage
    newImageRef = CGBitmapContextCreateImage(context)
    newImage = UIImage.imageWithCGImage(newImageRef)

    return newImage
  end
end