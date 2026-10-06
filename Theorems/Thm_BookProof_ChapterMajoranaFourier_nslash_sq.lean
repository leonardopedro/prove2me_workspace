-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.nslash_sq
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.nslash_sq (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    nslash n * nslash n = -1 := by sorry
