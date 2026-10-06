-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.majoranaFourier_boostBlock_unitary
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.majoranaFourier_boostBlock_unitary
    (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q)
    (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    (boostBlock (boostC m q) (boostS m q) (Aop n))ᴴ *
      boostBlock (boostC m q) (boostS m q) (Aop n) = 1 := by sorry
