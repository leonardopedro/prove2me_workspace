-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.vars_redFormPoly_subset
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}
variable (nu : ℝ) (k : Fin 3 → ℝ)



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.vars_redFormPoly_subset (nu : ℝ) (k : Fin 3 → ℝ) (p : Fin n) (r : Fin 7) :
    (redFormPoly nu k n p r).vars ⊆ Finset.image (redIdx p) Finset.univ := by sorry
