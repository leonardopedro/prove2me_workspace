-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSymmetric
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

inearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

theorem BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSymmetric (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by sorry
