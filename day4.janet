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
  :1920-1999 (* "19" (range "29") :d)
  :2000-2002 (* "200" (range "02"))
  :2010-2019 (* "201" :d)
  :2020-2029 (* "202" :d)
  :50-89 (* (range "58") :d)
  :90-93 (* "9" (range "03"))
  :60-69 (* "6" :d)
  :70-76 (* "7" (range "06"))
  :hgt-cm (* "1" (+ :50-89 :90-93) "cm")
  :hgt-in (* (+ "59" :60-69 :70-76) "in")
  :hex-digit (+ :d (range "af"))
  
  :ecl-color (+ "amb" "blu" "brn" "gry" "grn" "hzl" "oth")
  :byr (<- (* "byr:" (+ :1920-1999 :2000-2002)))
  :iyr (<- (* "iyr:" (+ "2020" :2010-2019)))
  :eyr (<- (* "eyr:" (+ "2030" :2020-2029)))
  :hgt (<- (* "hgt:" (+ :hgt-cm :hgt-in)))
  :hcl (<- (* "hcl:" "#" (repeat 6 :hex-digit)))
  :ecl (<- (* "ecl:" :ecl-color))
  :pid (<- (* "pid:" (repeat 9 :d)))
  :cid (* "cid:" :w+)
  :field (+ :byr :iyr :eyr :hgt :hcl :ecl :pid :cid)
  :passport (some (* :field (at-most 1 :s)))
  :main :passport
})

(defn part-1 []
  (let [docs (->> "input/day4.txt" slurp (string/split "\n\n"))]
    (count |(= 7 (length (peg/match grammar-1 $))) docs)))

(defn part-2 []
  (let [docs (->> "input/day4.txt" slurp (string/split "\n\n"))]
(count |(= 7 (length (default (peg/match grammar-2 $) @[]))) docs)))

(print (part-1))
(print (part-2))
