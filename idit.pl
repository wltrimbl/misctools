#!/usr/bin/perl
# this script sorts standard in according to patterns that
# look kind of like particuar technology basecallers.
# output goes into three files; unidentified reads to std out.
# W. Trimble March 2011
# Copyright 2011, University of Chicago

while(<>)
{
chomp;
@fields = split(/\t/, $_);
$tech      = "NOT IDD";
$accession = "";
$uaccno    = "";
if(	/>SCUMS_READ_/)
	{$tech = "[454]";}
elsif(	/JCVI_READ_\d{6,13}/)
	{$tech = "[Sanger]";}
elsif(	/JCVI_READ_\d{3,5}/)
	{$tech = "[Sanger]";}
elsif(	/>NCBI_READ_\d{10,13}/)
	{$tech = "[Sanger]";}
#elsif(	/_READ_\d{3,13}/)
#	{$tech = "[Sanger]";}
elsif(	/>([A-Z][\dA-Z]{13})[_\W$ ]/)
	{$tech = "[454]"; $uaccno = $1;}
elsif(	/>([A-Z][\dA-Z]{13})\W?length=/)
	{$tech = "[454]"; $uaccno = $1;}
elsif(	/uaccno=([A-Z][\dA-Z]{13})[_\W$ ]/)
	{$tech = "[454]"; $uaccno = $1;}
elsif(	/>(.*)_([A-Z][\dA-Z]{13})[_\W$ ]/)
	{$tech = "[454]"; $uaccno = $2;}
elsif(	/[=>_| -]([A-Z][\dA-Z]{13})[_\W$ ]/)
	{$tech = "[454]"; $uaccno = $1;}
elsif(	/>[A-Z]{7}.CL1Contig/)
	{$tech = "[Sanger]";}
elsif(	/CL1Contig/)
	{$tech = "[Sanger]";}
elsif(	/>NCBI_...._READ_\d{6,14}/)
	{$tech = "[Sanger]";}
elsif(	/>(SR[A-Z]\d{6})/)
	{$tech = "[SRA]"; $accession = $1;}
elsif(	/>r\d\.\d/)
	{$tech = "[Artificial]";}
elsif(	/_r1.1/)
	{$tech = "[Artificial]";}
elsif(	/complete genome/)
	{$tech = "[Artificial]";}
#elsif(	/>gi[|_]\d{6}/)
#	{$tech = "[Artificial]";}
elsif(	/>SOLEXA/)
	{$tech = "[Illumina]";}
elsif(	/[_\W]gi[_\W]\d{4,}[_\W]gb[_\W]([\w.]*)[\W\$]/)
	{$tech = "[GENBANK]";     $accession=$1;}
elsif(	/[_\W]gb[_\W]([\w.]*)[\W\$]/)
	{$tech = "[GENBANK]";     $accession=$1;}
elsif(	/[_\W]gi[_\W]\d{4,}[_\W]dbj[_\W]([\w.]*)[\W\$]/)
	{$tech = "[GENBANK]";     $accession=$1;}
elsif(	/[_\W]gi[_\W]\d{4,}[_\W]emb[_\W]([\w.]*)[\W\$]/)
	{$tech = "[GENBANK]";     $accession=$1;}
elsif(	/[_\W]gi[_\W]\d{4,}[_\W]ref[_\W]([\w.]*)[\W\$]/)
	{$tech = "[Artificial]";  $accession=$1;}
elsif(	/>\w\w[\w\d-]*:\d{1,2}:\d{1,3}:\d{1,6}:\d{1,6}#?/)
	{$tech = "[Illumina]";}
elsif(	/>\w\w[\w\d-]*_\d{1,2}_\d{1,3}_\d{1,6}_\d{1,6}#/)
	{$tech = "[Illumina]";}
#elsif(	/[|_>-]\d{1,2}_\d{1,3}_\d{1,6}_\d{1,6}[|_$-]{1}/)
#	{$tech = "[Illumina~]";}
#elsif(	/>\d{1,2}_\d{1,3}_\d{1,6}_\d{1,6}/)
#	{$tech = "[Illumina~]";}
#elsif(	/[|>_]\d{6}_\d{4}_\d{4}[|_ -]?length=/)
#	{$tech = "[454]";}
#elsif(	/[|>_]\d{6}_\d{4}_\d{4}/)
#	{$tech = "[454]";}

$dataset = "";
if ($fields[0] =~ /\/proc\/(\d{7}.\d)\.fa/ ) {$dataset = $1;} else {$dataset = $fields[0];}
shift(@fields);
print "$dataset\t" . join("\t",@fields)."\t$tech\t$accession\t$uaccno\n";

}
