function cellUnit = normalizeCellHistogram(cellUnit)
    cellUnit.binsN = cellUnit.bins/sum(cellUnit.bins);
end