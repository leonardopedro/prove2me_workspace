-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.exists_eigenvalue_of_isFunctionOfSpectrum
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Theorems.Thm_BookProof_ChapterGaugeUnconstrainedSpectrum_diagOp_basisVec
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq X] {T : Op X}
    (hT : IsFunctionOfSpectrum T) (y : X) :
    ∃ c : ℂ, T (basisVec y) = c • basisVec y := by

  obtain ⟨d, rfl⟩ := hT
  exact ⟨d y, diagOp_basisVec d y⟩
