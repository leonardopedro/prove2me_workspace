-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.gaugeMassForm_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Finset

noncomputable section


theorem BookProof.SmHiggsVacuum.gaugeMassForm_eq_zero_iff (X : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ) (u : Fin 4 → ℝ) :
    gaugeMassForm X u = 0 ↔ ∀ i, (X i).mulVec u = 0 := by sorry
