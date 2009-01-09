#!/usr/bin/perl
use strict;
use warnings;
use Fcntl qw(SEEK_SET);
use Time::HiRes qw(gettimeofday);

sub copy{
	my $dest    = $_[0];
	my $destoff = $_[1];
	my $size    = $_[2];
	my $src     = $_[3];
	my $srcoff  = $_[4];
	
	if(!$src)
	{
		$src="/dev/urandom";
		$srcoff=0;
	}
	open(SRCFP, "$src") || die "cannot open seed file";
	binmode(SRCFP);
	sysseek(SRCFP, $srcoff, SEEK_SET);
	if(-s($dest)){
		open(DESTFP, "+<$dest") || die "cannot open seed file";
	}else{
		open(DESTFP, ">$dest") || die "cannot open seed file";
	}
	sysseek(DESTFP, $destoff, SEEK_SET);
	binmode(DESTFP);
	
	my $buf;
	my $reads;
	while($size)
	{
		if($size<65536){
			$reads=$size;
		}else{
			$reads=65536;
		}
		sysread(SRCFP, $buf, $reads);
		syswrite(DESTFP, $buf, $reads);
		$size-=$reads;
	}
	close(SRCFP);
	close(DESTFP);
}

# overwritefile name, off, size
sub overwritefile{
	my $name    = $_[0];
	my $off     = $_[1];
	my $size    = $_[2];
	print "overwritefile $name off $off size $size... ";
	copy($name, $off, $size);
	print "OK\n";
}

# insertfile name, off, size
sub insertfile{
	my $name    = $_[0];
	my $off	    = $_[1];
	my $size    = $_[2];
	print "insertfile $name off $off size $size... ";
	
	my $filesize = -s($name);
	copy("a.tmp", 0, $off, $name, 0);
	copy("a.tmp", $off, $size);
	copy("a.tmp", $off+$size, $filesize-$off, $name, $off);
	system("rm $name -f");
	system("mv a.tmp $name");
	print "OK\n"
}

# appendfile name, size
sub appendfile{
	my $name    = $_[0];
	my $size    = $_[1];
	print "appendfile $name size $size... ";
	my $filesize = -s($name);
	copy($name, $filesize, $size);
	print "OK\n"
}

# benchmark 'scripts'
sub benchmark{
	(my $start_s, my $start_us) = gettimeofday;
	my @net=eval($_[0]);
	(my $end_s, my $end_us) = gettimeofday;
	my $time_used=($end_s-$start_s)+($end_us-$start_us)/1000000;
	printf("  time spent %.3f.", $time_used);
	printf(" net send $net[0] bytes, recieve $net[1] bytes\n");
}

# rsyncto path
sub rsyncto{
	my $file = $_[0];
	my $cmd = "rsync -zr --progress $file rsync://root\@192.168.0.100/ftp/";
	print $cmd."\n";
	my @result = split(" ", `$cmd | awk '/'sent'/{print \$2,\$5}'`);
}

# rsyncfrom path
sub rsyncfrom{
	my $file = $_[0];
	my $cmd = "rsync -zr --progress rsync://root\@192.168.0.100/ftp/$file $file";
	print $cmd."\n";
	my @result = split(" ", `$cmd | awk '/'sent'/{print \$2,\$5}'`);
}

# genfile name, size
sub genfile{
	my $name    = $_[0];
	my $size    = $_[1];
	print "generating $_[0] size $_[1] ... ";
	system("rm $name -f");
	copy($name, 0, $size);
	print "OK\n"
}

sub gendir{
	my $path =$_[0];
	my $num	=$_[1];
	for(my $i=0;$i<$num;$i++){
		mkdir "$path/$i";
	}
}

genfile("test1G", 1000000000+rand(10000000));
benchmark('rsyncto("test1G");');
appendfile("test1G", 1000);
benchmark('rsyncto("test1G");');
overwritefile("test1G", 12345678, 1000);
benchmark('rsyncto("test1G");');
insertfile("test1G", 123456789, 1000);
benchmark('rsyncto("test1G");');

