(defn slurp-lines [path]
  (string/split "\n" (string/trim (slurp path))))

(defn check1 [min max letter & letters]
  (let [[min max] (map scan-number [min max])
        len (length letters)]
    (<= min len max)))

(defn check2 [i1 i2 letter & password]
  (let [[i1 i2] (map |(- (scan-number $) 1) [i1 i2])]
  (one? (count |(= letter ($ password)) [i1 i2]))))

(def pat1 (peg/compile ~(* (<- :d+ :min) "-" (<- :d+ :max) " " (<- :a :letter) ": " (some (+ (<- (backmatch :letter)) 1)))))
(def pat2 (peg/compile '(* (<- :d+ :min) "-" (<- :d+ :max) " " (<- :a :required) ": " (some (+ (<- :a) 1)))))

(defn part-1 [] (count |(check1 ;(peg/match pat1 $)) (slurp-lines "input/day2.txt")))
(defn part-2 [] (count |(check2 ;(peg/match pat2 $)) (slurp-lines "input/day2.txt")))

(print (part-1))
(print (part-2))
