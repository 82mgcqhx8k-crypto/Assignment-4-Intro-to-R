
R version 4.6.1 (2026-06-24) -- "Happy Hop"
Copyright (C) 2026 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin23

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.83 (8608) aarch64-apple-darwin23]

[Workspace restored from /Users/yoshi_zen25/.RData]
[History restored from /Users/yoshi_zen25/.Rapp.history]

> # Read file
> fasta <- readLines("~/Downloads/chr1_GL383518v1_alt.fa")
> 
> # Remove header lines and combine sequence lines
> sequence_lines <- fasta[!startsWith(fasta, ">")]
> sequence <- paste0(trimws(sequence_lines), collapse = "")
> 
> # Print 10th/758th letter
> cat("10th letter:", substr(sequence, 10, 10), "\n")
10th letter: c 
> cat("758th letter:", substr(sequence, 758, 758), "\n\n")
758th letter: a 

> 
> 
> # Reverse complement
> reverse_complement <- chartr("ACGT", "TGCA", sequence)
> reverse_complement <- paste(
+   rev(strsplit(reverse_complement, "")[[1]]),
+   collapse = ""
+ )
> 
> cat("79th letter:", substr(reverse_complement, 79, 79), "\n")
79th letter: G 
> cat("Letters 500 - 800:",
+     substr(reverse_complement, 500, 800), "\n\n")
Letters 500 - 800: ctaggtgggcggaaccggatggtatcacgaccctaatatccgcactcggtgacacggaccggtcttaatctgcatctaaaTAATCATGACTTTCCTATTTGTTGTGTTTCTTGGACAGGTTTATACTAAATAAGAAATTATGTAGTATACTAAATAATACTAaaaaaaaactttacctcacagagagacagtgggtccgacctcacgtcaccgccctagagccgaatggcgttggaggcggagggtccaagttcgttaagaggacagtgtcggagggtttatcgaccctgatgtccgtgtg 

> 
> 
> # Count bases in terms of 1,000 base segments
> starts <- seq(0, nchar(sequence) - 1, by = 1000)
> 
> my_dict <- lapply(starts, function(start) {
+   segment <- substr(sequence, start + 1, min(start + 1000, nchar(sequence)))
+ 
+   c(
+     A = nchar(gsub("[^A]", "", segment)),
+     C = nchar(gsub("[^C]", "", segment)),
+     G = nchar(gsub("[^G]", "", segment)),
+     T = nchar(gsub("[^T]", "", segment))
+   )
+ })
> 
> # Name segments by zero based starting position 
> names(my_dict) <- as.character(starts)
> 
> cat("Segment counts at Position 5000\n")
Segment counts at Position 5000
> print(my_dict[["5000"]])
 A  C  G  T 
26 14  9 34 
> cat("\n")

> 
> 
> # Summary of counts for kilobase
> first_kilo <- my_dict[["0"]]
> cat("First kilobase:", first_kilo, "\n")
First kilobase: 22 5 4 24 
> 
> kilo_sum <- vapply(my_dict, sum, numeric(1))
> cat("Sum of each kilobase list:", kilo_sum, "\n")
Sum of each kilobase list: 55 140 9 193 340 83 13 2 27 51 14 1 91 567 221 14 45 247 150 21 143 86 81 146 195 215 93 0 2 34 54 4 29 118 708 25 30 65 0 115 359 110 386 323 776 898 554 814 385 266 500 694 571 380 277 6 10 514 548 970 951 598 568 708 1000 1000 1000 855 732 821 93 700 152 470 1000 248 824 929 633 837 1000 894 68 0 973 1000 908 914 960 1000 968 1000 920 945 866 1000 1000 1000 347 398 500 30 0 0 201 17 167 366 152 700 982 956 759 574 408 647 1000 896 966 1000 923 920 838 910 928 980 960 272 893 969 586 193 386 739 1000 622 697 446 446 448 400 394 397 48 998 572 247 98 231 9 0 0 25 439 488 447 428 186 16 217 9 0 42 34 161 77 185 55 683 1000 188 189 8 457 848 50 168 445 319 203 474 145 236 
> 
> # See if counts match segment's length
> for (i in seq_along(starts)) {
+   start <- starts[i]
+   expected_sum <- min(1000, nchar(sequence) - start)
+ 
+   if (kilo_sum[i] != expected_sum) {
+     cat(
+       "Segment starting at", start, ": sum is", kilo_sum[i],
+       ", expected", expected_sum, "\n"
+     )
+   }
+ }
Segment starting at 0 : sum is 55 , expected 1000 
Segment starting at 1000 : sum is 140 , expected 1000 
Segment starting at 2000 : sum is 9 , expected 1000 
Segment starting at 3000 : sum is 193 , expected 1000 
Segment starting at 4000 : sum is 340 , expected 1000 
Segment starting at 5000 : sum is 83 , expected 1000 
Segment starting at 6000 : sum is 13 , expected 1000 
Segment starting at 7000 : sum is 2 , expected 1000 
Segment starting at 8000 : sum is 27 , expected 1000 
Segment starting at 9000 : sum is 51 , expected 1000 
Segment starting at 10000 : sum is 14 , expected 1000 
Segment starting at 11000 : sum is 1 , expected 1000 
Segment starting at 12000 : sum is 91 , expected 1000 
Segment starting at 13000 : sum is 567 , expected 1000 
Segment starting at 14000 : sum is 221 , expected 1000 
Segment starting at 15000 : sum is 14 , expected 1000 
Segment starting at 16000 : sum is 45 , expected 1000 
Segment starting at 17000 : sum is 247 , expected 1000 
Segment starting at 18000 : sum is 150 , expected 1000 
Segment starting at 19000 : sum is 21 , expected 1000 
Segment starting at 20000 : sum is 143 , expected 1000 
Segment starting at 21000 : sum is 86 , expected 1000 
Segment starting at 22000 : sum is 81 , expected 1000 
Segment starting at 23000 : sum is 146 , expected 1000 
Segment starting at 24000 : sum is 195 , expected 1000 
Segment starting at 25000 : sum is 215 , expected 1000 
Segment starting at 26000 : sum is 93 , expected 1000 
Segment starting at 27000 : sum is 0 , expected 1000 
Segment starting at 28000 : sum is 2 , expected 1000 
Segment starting at 29000 : sum is 34 , expected 1000 
Segment starting at 30000 : sum is 54 , expected 1000 
Segment starting at 31000 : sum is 4 , expected 1000 
Segment starting at 32000 : sum is 29 , expected 1000 
Segment starting at 33000 : sum is 118 , expected 1000 
Segment starting at 34000 : sum is 708 , expected 1000 
Segment starting at 35000 : sum is 25 , expected 1000 
Segment starting at 36000 : sum is 30 , expected 1000 
Segment starting at 37000 : sum is 65 , expected 1000 
Segment starting at 38000 : sum is 0 , expected 1000 
Segment starting at 39000 : sum is 115 , expected 1000 
Segment starting at 40000 : sum is 359 , expected 1000 
Segment starting at 41000 : sum is 110 , expected 1000 
Segment starting at 42000 : sum is 386 , expected 1000 
Segment starting at 43000 : sum is 323 , expected 1000 
Segment starting at 44000 : sum is 776 , expected 1000 
Segment starting at 45000 : sum is 898 , expected 1000 
Segment starting at 46000 : sum is 554 , expected 1000 
Segment starting at 47000 : sum is 814 , expected 1000 
Segment starting at 48000 : sum is 385 , expected 1000 
Segment starting at 49000 : sum is 266 , expected 1000 
Segment starting at 50000 : sum is 500 , expected 1000 
Segment starting at 51000 : sum is 694 , expected 1000 
Segment starting at 52000 : sum is 571 , expected 1000 
Segment starting at 53000 : sum is 380 , expected 1000 
Segment starting at 54000 : sum is 277 , expected 1000 
Segment starting at 55000 : sum is 6 , expected 1000 
Segment starting at 56000 : sum is 10 , expected 1000 
Segment starting at 57000 : sum is 514 , expected 1000 
Segment starting at 58000 : sum is 548 , expected 1000 
Segment starting at 59000 : sum is 970 , expected 1000 
Segment starting at 60000 : sum is 951 , expected 1000 
Segment starting at 61000 : sum is 598 , expected 1000 
Segment starting at 62000 : sum is 568 , expected 1000 
Segment starting at 63000 : sum is 708 , expected 1000 
Segment starting at 67000 : sum is 855 , expected 1000 
Segment starting at 68000 : sum is 732 , expected 1000 
Segment starting at 69000 : sum is 821 , expected 1000 
Segment starting at 70000 : sum is 93 , expected 1000 
Segment starting at 71000 : sum is 700 , expected 1000 
Segment starting at 72000 : sum is 152 , expected 1000 
Segment starting at 73000 : sum is 470 , expected 1000 
Segment starting at 75000 : sum is 248 , expected 1000 
Segment starting at 76000 : sum is 824 , expected 1000 
Segment starting at 77000 : sum is 929 , expected 1000 
Segment starting at 78000 : sum is 633 , expected 1000 
Segment starting at 79000 : sum is 837 , expected 1000 
Segment starting at 81000 : sum is 894 , expected 1000 
Segment starting at 82000 : sum is 68 , expected 1000 
Segment starting at 83000 : sum is 0 , expected 1000 
Segment starting at 84000 : sum is 973 , expected 1000 
Segment starting at 86000 : sum is 908 , expected 1000 
Segment starting at 87000 : sum is 914 , expected 1000 
Segment starting at 88000 : sum is 960 , expected 1000 
Segment starting at 90000 : sum is 968 , expected 1000 
Segment starting at 92000 : sum is 920 , expected 1000 
Segment starting at 93000 : sum is 945 , expected 1000 
Segment starting at 94000 : sum is 866 , expected 1000 
Segment starting at 98000 : sum is 347 , expected 1000 
Segment starting at 99000 : sum is 398 , expected 1000 
Segment starting at 1e+05 : sum is 500 , expected 1000 
Segment starting at 101000 : sum is 30 , expected 1000 
Segment starting at 102000 : sum is 0 , expected 1000 
Segment starting at 103000 : sum is 0 , expected 1000 
Segment starting at 104000 : sum is 201 , expected 1000 
Segment starting at 105000 : sum is 17 , expected 1000 
Segment starting at 106000 : sum is 167 , expected 1000 
Segment starting at 107000 : sum is 366 , expected 1000 
Segment starting at 108000 : sum is 152 , expected 1000 
Segment starting at 109000 : sum is 700 , expected 1000 
Segment starting at 110000 : sum is 982 , expected 1000 
Segment starting at 111000 : sum is 956 , expected 1000 
Segment starting at 112000 : sum is 759 , expected 1000 
Segment starting at 113000 : sum is 574 , expected 1000 
Segment starting at 114000 : sum is 408 , expected 1000 
Segment starting at 115000 : sum is 647 , expected 1000 
Segment starting at 117000 : sum is 896 , expected 1000 
Segment starting at 118000 : sum is 966 , expected 1000 
Segment starting at 120000 : sum is 923 , expected 1000 
Segment starting at 121000 : sum is 920 , expected 1000 
Segment starting at 122000 : sum is 838 , expected 1000 
Segment starting at 123000 : sum is 910 , expected 1000 
Segment starting at 124000 : sum is 928 , expected 1000 
Segment starting at 125000 : sum is 980 , expected 1000 
Segment starting at 126000 : sum is 960 , expected 1000 
Segment starting at 127000 : sum is 272 , expected 1000 
Segment starting at 128000 : sum is 893 , expected 1000 
Segment starting at 129000 : sum is 969 , expected 1000 
Segment starting at 130000 : sum is 586 , expected 1000 
Segment starting at 131000 : sum is 193 , expected 1000 
Segment starting at 132000 : sum is 386 , expected 1000 
Segment starting at 133000 : sum is 739 , expected 1000 
Segment starting at 135000 : sum is 622 , expected 1000 
Segment starting at 136000 : sum is 697 , expected 1000 
Segment starting at 137000 : sum is 446 , expected 1000 
Segment starting at 138000 : sum is 446 , expected 1000 
Segment starting at 139000 : sum is 448 , expected 1000 
Segment starting at 140000 : sum is 400 , expected 1000 
Segment starting at 141000 : sum is 394 , expected 1000 
Segment starting at 142000 : sum is 397 , expected 1000 
Segment starting at 143000 : sum is 48 , expected 1000 
Segment starting at 144000 : sum is 998 , expected 1000 
Segment starting at 145000 : sum is 572 , expected 1000 
Segment starting at 146000 : sum is 247 , expected 1000 
Segment starting at 147000 : sum is 98 , expected 1000 
Segment starting at 148000 : sum is 231 , expected 1000 
Segment starting at 149000 : sum is 9 , expected 1000 
Segment starting at 150000 : sum is 0 , expected 1000 
Segment starting at 151000 : sum is 0 , expected 1000 
Segment starting at 152000 : sum is 25 , expected 1000 
Segment starting at 153000 : sum is 439 , expected 1000 
Segment starting at 154000 : sum is 488 , expected 1000 
Segment starting at 155000 : sum is 447 , expected 1000 
Segment starting at 156000 : sum is 428 , expected 1000 
Segment starting at 157000 : sum is 186 , expected 1000 
Segment starting at 158000 : sum is 16 , expected 1000 
Segment starting at 159000 : sum is 217 , expected 1000 
Segment starting at 160000 : sum is 9 , expected 1000 
Segment starting at 161000 : sum is 0 , expected 1000 
Segment starting at 162000 : sum is 42 , expected 1000 
Segment starting at 163000 : sum is 34 , expected 1000 
Segment starting at 164000 : sum is 161 , expected 1000 
Segment starting at 165000 : sum is 77 , expected 1000 
Segment starting at 166000 : sum is 185 , expected 1000 
Segment starting at 167000 : sum is 55 , expected 1000 
Segment starting at 168000 : sum is 683 , expected 1000 
Segment starting at 170000 : sum is 188 , expected 1000 
Segment starting at 171000 : sum is 189 , expected 1000 
Segment starting at 172000 : sum is 8 , expected 1000 
Segment starting at 173000 : sum is 457 , expected 1000 
Segment starting at 174000 : sum is 848 , expected 1000 
Segment starting at 175000 : sum is 50 , expected 1000 
Segment starting at 176000 : sum is 168 , expected 1000 
Segment starting at 177000 : sum is 445 , expected 1000 
Segment starting at 178000 : sum is 319 , expected 1000 
Segment starting at 179000 : sum is 203 , expected 1000 
Segment starting at 180000 : sum is 474 , expected 1000 
Segment starting at 181000 : sum is 145 , expected 1000 
Segment starting at 182000 : sum is 236 , expected 439 
> 
> 
> # Answer to e1 and e2
> # e1: the expected sum for each list is 1,000
> # e2: there were many lists there didn't equal the expected value of sum
Error in file.choose(TRUE) : file choice cancelled
> 