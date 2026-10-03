-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.velocityLin_norm_le
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_summable_normSq
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

theorem solution (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ :=
  _apply (v : LinfZ) (f : L2Z) (k : ℤ) :
      ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl
  
  theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
    refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
    rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
    simp only [Real.rpow_natCast]
    have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
        ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
      intro k
      have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
        simp [Complex.norm_real]
      rw [hnorm, mul_pow]
      have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
        nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
      nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
    calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
        ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^
