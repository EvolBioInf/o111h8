BEGIN {
  if (!d) {
    print "Usage: awk -f printChildren.awk -v d=<dree.out>"
    exit 1
  }
}
{
  p = $1
  cmd = "cat " d
  while (cmd | getline) {
    if ($2 == p) {
      rank = $3
      genomes[rank] += $4
      if (!taxids[rank])
	taxids[rank] = $1
      else
	taxids[rank] = taxids[rank] "," $1
    }
  }
  close(cmd)
}
END {
  for (rank in genomes)
    print rank, genomes[rank], taxids[rank]
}
