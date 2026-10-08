-- Generated from ChapterFreeFieldBornCont.lean — theorem BookProof.ChapterFreeFieldBornCont.continuous_bornSection
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
open BookProof.ChapterFreeFieldBornCont


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornCont.continuous_bornSection :
    Continuous (bornSection : (Fin n → ℝ) → EuclideanSpace ℝ (Fin n)) := by sorry
