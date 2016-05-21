class ColorProcess
    def interpolate(s1, s2, s3, s4, frac1, frac2)
      #this method receives 4 equidistant sensors and the relative position
      #of the point we want to interpolate. It computes the interpolated
      #color and opacity using a bilinear interpolation
      c1 = Array.new(3);
      c2 = Array.new(3);
      
      for i in 0..2
        c1[i] = (s2.color[i] - s1.color[i]) * frac2 + s1.color[i]
        c2[i] = (s4.color[i] - s3.color[i]) * frac2 + s3.color[i]
      end
      op1 = (s2.opacity - s1.opacity) * frac2 + s1.opacity;
      op2 = (s4.opacity - s3.opacity) * frac2 + s3.opacity;
    
      interpolated = Array.new;
      for i in 0..2
        interpolated[i] = (c2[i] - c1[i]) * frac1 + c1[i];
      end
      opacity = (op2 - op1) * frac1 + op1;
    
      return {:color => interpolated, :opacity => opacity}
    end
end