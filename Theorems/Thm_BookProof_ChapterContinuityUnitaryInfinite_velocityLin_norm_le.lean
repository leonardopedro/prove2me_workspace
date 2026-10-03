-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.velocityLin_norm_le
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

theorem BookProof.ChapterContinuityUnitaryInfinite.velocityLin_norm_le (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by sorry
