-- Generated from ChapterFreeFieldBornCont.lean — theorem BookProof.ChapterFreeFieldBornCont.continuous_bornMap
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
open BookProof.ChapterFreeFieldBornCont

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj



theorem BookProof.ChapterFreeFieldBornCont.continuous_bornMap :
    Continuous (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ)) := by sorry
