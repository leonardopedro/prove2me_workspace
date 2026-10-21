-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.diagOp_basisVec
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq X] (d : X → ℂ) (y : X) :
    diagOp d (basisVec y) = d y • basisVec y := by

  funext x
  simp only [diagOp_apply, basisVec, Pi.smul_apply, smul_eq_mul]
  by_cases hx : x = y <;> simp [hx]
