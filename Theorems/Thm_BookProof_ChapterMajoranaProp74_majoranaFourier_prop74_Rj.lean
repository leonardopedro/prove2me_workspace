-- Generated from ChapterMajoranaProp74.lean — theorem BookProof.ChapterMajoranaProp74.majoranaFourier_prop74_Rj
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

theorem BookProof.ChapterMajoranaProp74.majoranaFourier_prop74_Rj (n : Fin 3 → ℝ) (c s pj : ℝ) :
    Dmat (dgamma 0) pj * Sinv (Aop n) c s = Sinv (Aop n) c s * Dmat (dgamma 0) pj := by sorry
