use strict;
use warnings;

sub usage {
    die "USAGE: giffer.pl [video] [output] [start time] [length]";
}

my $video = $ARGV[0] or usage();
my $out = $ARGV[1] or usage();
my $t1 = $ARGV[2] or usage();
my $t2 = $ARGV[3] or usage();

# my $gif = $video;
# $gif =~ s/\.[0-9a-zA-Z]+$/.gif/;

# quality defaults to 320x240, 15 fps
system("ffmpeg -y -i \"$video\" -ss $t1 -t $t2 -an -r 15 -s 320x240 123temp%03d.jpg");

my @imagelist = glob "123temp*.jpg";
my $images = "@imagelist";
print "Creating animated GIF.......";
system("convert -delay 1x15 $images -deconstruct -coalesce -layers optimize -matte \"$out\"");

print "Removing temp files...";
unlink glob "123temp*.jpg";

print "Done!";
