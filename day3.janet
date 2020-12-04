(defn indexed [ind]
  (map tuple (range (length ind)) ind))

(defn chars [str]
  (map string/from-bytes str))

(defn slurp-lines [path]
  (string/split "\n" (string/trim (slurp path))))

(defn cb [seen [row-pos row]]
  # (print (length row))
  (let [col-pos (% (* 3 row-pos) 31)
        tree? (truthy? (find |(= col-pos $) row))]
    (print col-pos)
    (if tree? (inc seen) seen)))

(defn part-1 []
  (let [lines (slurp-lines "input/day3.txt")
        trees (indexed (map |(peg/find-all "#" $) lines))]
    (printf "%q" trees)
    (reduce cb 0 trees)))

(print (part-1))
