-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.permOp_basisVec
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq X] (σ : Equiv.Perm X) (y : X) :
    permOp σ (basisVec y) = basisVec (σ y) := by

  funext x
  simp only [permOp_apply, basisVec]
  by_cases hx : x = σ y
  · simp [hx]
  · have : σ.symm x ≠ y := fun h => hx (by rw [← h, Equiv.apply_symm_apply])
    simp [hx, this]
