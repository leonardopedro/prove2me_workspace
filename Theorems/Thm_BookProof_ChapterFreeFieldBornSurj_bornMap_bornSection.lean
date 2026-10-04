-- Generated from ChapterFreeFieldBornSurj.lean — theorem BookProof.ChapterFreeFieldBornSurj.bornMap_bornSection
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSurj

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBornSurj.bornMap_bornSection {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    bornMap (bornSection p) = p := by sorry
