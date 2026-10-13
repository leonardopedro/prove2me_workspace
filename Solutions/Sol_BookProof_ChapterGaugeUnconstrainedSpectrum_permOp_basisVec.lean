-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.permOp_basisVec
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterE4
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterE4




variable {X : Type*}

variable {X : Type*}


@[simp] private theorem permOp_apply (σ : Equiv.Perm X) (f : X → ℂ) (x : X) :
    permOp σ f x = f (σ.symm x) := rfl

set_option maxHeartbeats 1000000 in

theorem solution [DecidableEq X] (σ : Equiv.Perm X) (y : X) :
    permOp σ (basisVec y) = basisVec (σ y) := by
  funext x
  simp only [permOp_apply, basisVec]
  by_cases hx : x = σ y
  · simp [hx]
  · have : σ.symm x ≠ y := fun h => hx (by rw [← h, Equiv.apply_symm_apply])
    simp [hx, this]
