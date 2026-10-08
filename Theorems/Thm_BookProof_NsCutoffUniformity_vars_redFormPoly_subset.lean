-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.vars_redFormPoly_subset
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity



open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {ι : Type*}
variable (nu : ℝ) (k : Fin 3 → ℝ)

theorem BookProof.NsCutoffUniformity.vars_redFormPoly_subset (nu : ℝ) (k : Fin 3 → ℝ) (p : Fin n) (r : Fin 7) :
    (redFormPoly nu k n p r).vars ⊆ Finset.image (redIdx p) Finset.univ := by sorry
