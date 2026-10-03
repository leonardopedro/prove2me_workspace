-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSymmetric
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
inearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

theorem solution (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k :=
  apply (v : LinfZ) (f : L2Z) (k : ℤ) :
      ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl
  
  theorem velocityOp_isSymmetric (v : LinfZ) :
      (velocityOp v : L2
