#!/usr/local/bin/gnuplot --persist
#
# Hent 4 kolonner med data fra Tekna excel arket som brukes under lønnsforhandlingene og lim det inn en fil "statistikk.txt"
#
# Kjør fila med "gnuplot.sh -c plotData.gp" resultatet finner du i "plot.png"
#
set title "Årslønn i Telenor og antall Tekna medlemmer"
set xrange [2025:1980]
set y2range [0:50]
set yrange [0:1500000]
set ytics nomirror
set y2label 'Antall 0:50'
set ylabel 'Lønn'
set boxwidth 0.85 relative
set style fill solid 0.7
set grid
set terminal png size 3000, 1500
set output 'plot.png'
plot "statistikk.txt" using 1:2 lw 2 lc 'blue' with boxes axis x1y2 title "Antall" ,"statistikk.txt" using 1:5 lw 4 lc 'red' with lines axis x1y1 title "Tekna" ,"statistikk.txt" using 1:3 lw 4 lc 'green' with lines axis x1y1 title "Telenor"
quit
