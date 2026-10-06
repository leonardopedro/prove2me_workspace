-- Generated from ChapterMajoranaProp74.lean — theorem BookProof.ChapterMajoranaProp74.majoranaFourier_prop74
import Mathlib
import Definitions.Def_ChapterMajoranaProp74
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier
open BookProof.ChapterMajoranaProp74


open Matrix


open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaProp74.majoranaFourier_prop74 (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q)
    (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    Qmat (dgamma 0) (nslash n) m q * Sinv (Aop n) (boostC m q) (boostS m q)
      = Sinv (Aop n) (boostC m q) (boostS m q) * Rmat (dgamma 0) (Ep m q) := by sorry
