use strict;
use warnings;

my $video = $ARGV[0] or die "USAGE: giffer.pl [video] [output] [start time] [length]";
my $out = $ARGV[1] or die "USAGE: giffer.pl [video] [output] [start time] [length]";
my $t1 = $ARGV[2] or die "USAGE: giffer.pl [video] [output] [start time] [length]";
my $t2 = $ARGV[3] or die "USAGE: giffer.pl [video] [output] [start time] [length]";

# my $gif = $video;
# $gif =~ s/\.[0-9a-zA-Z]+$/.gif/;

system("ffmpeg -y -i \"$video\" -ss $t1 -t $t2 -an 123temp%03d.jpg"); # 25 fps

my @imagelist = glob "123temp*.jpg";
my $images = "@imagelist";
print "Creating animated GIF.......";
system("convert -delay 1x25 $images -coalesce -layers OptimizeTransparency \"$out\"");

print "Removing temp files..."
unlink glob "123temp*.jpg";

print "Done!";
