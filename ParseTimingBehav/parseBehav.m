function x = parseBehav(in1, in2, in3, in4)

a = readTimingRun(in1,0);
b = readTimingRun(in2,0);
c = readTimingRun(in3,0);
d = readTimingRun(in4,0);


Timing = cell(1,7);

Timing{1} = sprintf('%s\n%s\n%s\n%s', a{1}, b{1}, c{1}, d{1});

Timing{2} = sprintf('%s\n%s\n%s\n%s', a{2}, b{2}, c{2}, d{2});
Timing{3} = sprintf('%s\n%s\n%s\n%s', a{3}, b{3}, c{3}, d{3});

Timing{4}= sprintf('%s\n%s\n%s\n%s', a{4}, b{4}, c{4}, d{4});
Timing{5} = sprintf('%s\n%s\n%s\n%s', a{5}, b{5}, c{5}, d{5});

Timing{6} = sprintf('%s\n%s\n%s\n%s', a{6}, b{6}, c{6}, d{6});
Timing{7} = sprintf('%s\n%s\n%s\n%s', a{7}, b{7}, c{7}, d{7});

x = Timing;
end