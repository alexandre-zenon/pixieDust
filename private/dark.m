function color=dark(color)
hsv=rgb2hsv(color);
newHsv=bsxfun(@times,hsv,[1 1 .5]);
color=hsv2rgb(newHsv);
end
