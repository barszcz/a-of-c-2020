(def grammar-1 '{
  :byr (<- (* "byr:" (some :S)))
  :iyr (<- (* "iyr:" (some :S)))
  :eyr (<- (* "eyr:" (some :S)))
  :hgt (<- (* "hgt:" (some :S)))
  :hcl (<- (* "hcl:" (some :S)))
  :ecl (<- (* "ecl:" (some :S)))
  :pid (<- (* "pid:" (some :S)))
  :cid (* "cid:" :w+)
  :field (+ :byr :iyr :eyr :hgt :hcl :ecl :pid :cid)
  :passport (some (* :field (at-most 1 :s)))
  :main :passport
})

(def grammar-2 '{
  :byr-20th-century (* "19" (range "29") :d)
  :byr-21st-century (* "200" (range "02"))
  :byr (<- (* "byr:" (+ :byr-20th-century :byr-21st-century)))
  :iyr-2010s (* "201" :d)
  :iyr (<- (* "iyr:" (+ "2020" :iyr-2010s)))
  :eyr-2020s (* "202" :d)
  :eyr (<- (* "eyr:" (+ "2030" :eyr-2020s)))
  :50-89 (* (range "58") :d)
  :90-93 (* "9" (range "03"))
  :hgt-cm (* "1" (+ :50-89 :90-93) "cm")
  :60-69 (* "6" :d)
  :70-76 (* "7" (range "06"))
  :hgt-in (* (+ "59" :60-69 :70-76) "in")
  :hgt (<- (* "hgt:" (+ :hgt-cm :hgt-in)))
  :hex-digit (+ :d (range "af"))
  :hcl (<- (* "hcl:" "#" (repeat 6 :hex-digit)))
  :ecl-color (+ "amb" "blu" "brn" "gry" "grn" "hzl" "oth")
  :ecl (<- (* "ecl:" :ecl-color))
  :pid (<- (* "pid:" (repeat 9 :d)))
  :cid (* "cid:" :w+)
  :field (+ :byr :iyr :eyr :hgt :hcl :ecl :pid :cid)
  :passport (some (* :field (at-most 1 :s)))
  :main :passport
})

(def valid `ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm`)

(def valid-without-cid `hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm`)

(def invalid `iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929`)

(def invalid-without-cid `hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in`)

(defn part-1 []
  (let [docs (->> "input/day4.txt" slurp (string/split "\n\n"))]
    (count |(= 7 (length (peg/match grammar-1 $))) docs)))

(defn part-2 []
  (let [docs (->> "input/day4.txt" slurp (string/split "\n\n"))]
(count |(= 7 (length (default (peg/match grammar-2 $) @[]))) docs)))

# (print (part-1))
(print (part-2))


# (assert (peg/match grammar valid))
# (assert (peg/match grammar valid-without-cid))
# (assert (not (peg/match grammar invalid)))
# (assert (not (peg/match grammar invalid-without-cid)))
# (peg/match grammar invalid)

# (peg/match grammar-2 `pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
# hcl:#623a2f`)
