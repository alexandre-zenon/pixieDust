function color=pastel(color)
hsv=rgb2hsv(color);
newHsv=bsxfun(@times,hsv,[1 .5 1]);
color=hsv2rgb(newHsv);
end