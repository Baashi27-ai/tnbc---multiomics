args <- commandArgs(trailingOnly=TRUE)
feat <- args[1]; labs <- args[2]; out <- args[3]
suppressWarnings(suppressMessages({ library(data.table) }))

X <- fread(feat)   # features: should have SID/sample/sample_id
L <- fread(labs)   # labels  : must contain CC_cluster and an ID column

# choose an ID key present in X
keyX <- intersect(names(X), c('SID','sample','sample_id','ID','id'))
if (!length(keyX)) stop('No ID column in features file (SID/sample/sample_id/ID/id).')
keyX <- keyX[1]

# make labels have the same key name as X
if (!(keyX %in% names(L))) {
  keyL <- intersect(names(L), c('SID','sample','sample_id','ID','id'))
  if (!length(keyL)) stop('No compatible ID column in labels file.')
  setnames(L, keyL[1], keyX)
}

if (!('CC_cluster' %in% names(L))) stop('labels file lacks CC_cluster.')

# add CC_cluster to X if missing
if (!('CC_cluster' %in% names(X))) {
  keep <- L[, .(get(keyX), CC_cluster)]
  setnames(keep, 'V1', keyX, skip_absent = TRUE)
  X <- merge(X, keep, by=keyX, all.x=TRUE)
}

fwrite(X, out, sep='\t')
cat('Wrote:', normalizePath(out), '\n')