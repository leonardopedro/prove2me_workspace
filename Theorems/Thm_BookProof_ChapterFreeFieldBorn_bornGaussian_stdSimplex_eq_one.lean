-- Generated from ChapterFreeFieldBorn.lean — theorem BookProof.ChapterFreeFieldBorn.bornGaussian_stdSimplex_eq_one
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBorn

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBorn.bornGaussian_stdSimplex_eq_one (hn : 0 < n) :
    ((sphereGaussian n).map bornMap) (stdSimplex ℝ (Fin n)) = 1 := by sorry
