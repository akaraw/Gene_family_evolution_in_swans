genome=$1
seqkit split $genome -p 24
function hmmer() {
base=$(basename "$1")
hmmscan --tblout ${base}.txt --cpu 1 -E 1e-5 --noali hmm_lib2/TreeFam9 $1
}
export -f hmmer
find $genome.split/ -type f -name "*fa" | parallel -j 24 hmmer {}
