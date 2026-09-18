-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.momentum_apply
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
theorem solution (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by

  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2
