
use strict;
use Test::More tests => 2;
use Text::Iconv;
use XML::TinyXML;
BEGIN { use_ok('XML::TinyXML::Selector') };

my $txml = XML::TinyXML->new();
$txml->loadFile("./t/t.xml");

my $utf8_output = $txml->dump;
$txml->setOutputEncoding("UTF-16");
my $utf16_output = $txml->dump;
my $iconv = Text::Iconv->new("UTF-8", "UTF-16");
# iconv won't change the declared document-encoding
# but we need it to be changed before comparing the 
# UTF-16 buffers
$utf8_output =~ s/utf-8/UTF-16/; 
my $converted = $iconv->convert($utf8_output);

is( $utf16_output, $converted );