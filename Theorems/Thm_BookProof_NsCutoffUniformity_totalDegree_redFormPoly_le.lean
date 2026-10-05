-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.totalDegree_redFormPoly_le
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}
variable (nu : ℝ) (k : Fin 3 → ℝ)



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.totalDegree_redFormPoly_le (p : Fin n) (r : Fin 7) :
    (redFormPoly nu k n p r).totalDegree ≤ 2 := by sorry
