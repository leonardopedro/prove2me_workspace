-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.cutoffBound_nonneg
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.cutoffBound_nonneg (nu : ℝ) {Λ : ℝ} (hΛ : 0 ≤ Λ) : 0 ≤ cutoffBound nu Λ := by sorry
