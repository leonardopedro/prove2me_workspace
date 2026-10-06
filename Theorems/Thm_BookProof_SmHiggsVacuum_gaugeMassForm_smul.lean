-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.gaugeMassForm_smul
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Finset

noncomputable section


theorem BookProof.SmHiggsVacuum.gaugeMassForm_smul (X : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ) (u : Fin 4 → ℝ) (c : ℝ) :
    gaugeMassForm (fun i => c • X i) u = c ^ 2 * gaugeMassForm X u := by sorry
