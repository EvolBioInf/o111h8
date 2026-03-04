BEGIN {
  if (!r) {
    print "Usage: awk -f ranks.awk -v r=<root> [-v d=<db>]"
    print "Find all combinations of ranks and the genomes they contain for a given root taxon."
    print "Example: awk -f ranks.awk -v r=562"
    exit 1
  }
  if (!d)
    d = "neidb"
  dcmd = sprintf("dree -n -l -g %d %s", r, d)
  atmp = "ants %s " d
    # For each dree result, use ants to find the chain of ranks
  while (dcmd | getline) {
    if (!/^#/) {
      taxid = $1
      if ($3 == "no")
	genomes = $5
      else
	genomes = $4
      acmd = sprintf(atmp, taxid)
      found = 0
      key = ""
      while (acmd | getline) {
	if ($2 == r)
	  found = 1
	if (found) {
	  k = $NF
	  if (k == "rank")
	    k = "no rank"
	  if (!key)
	    key = k
	  else
	    key = key ";" k
	}
      }
      close(acmd)
      counts[key] += genomes
    }
  }
  close(dcmd)
  for (key in counts) {
    print key, counts[key]
  }
}
