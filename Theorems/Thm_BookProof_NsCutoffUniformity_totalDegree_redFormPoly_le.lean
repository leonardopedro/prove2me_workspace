-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.totalDegree_redFormPoly_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4

variable {n : ℕ}
variable {ι : Type*}
variable (nu : ℝ) (k : Fin 3 → ℝ)



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.totalDegree_redFormPoly_le (p : Fin n) (r : Fin 7) :
    (redFormPoly nu k n p r).totalDegree ≤ 2 := by sorry
