-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.inner_shiftOp_left
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite

variable {X : Type*}

import Mathlib

theorem BookProof.ChapterContinuityUnitaryInfinite.inner_shiftOp_left (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by
    ext k
    rfl
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, sh := by sorry
