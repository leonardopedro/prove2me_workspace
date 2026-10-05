-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_ne_zero_of_shear
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_coord_succ
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) {c : ℝ} (hc : c ≠ 0) :
    saffH hκ c (basisState κ |c| 0) ≠ 0 := by

  intro h0
  have hcoord := saffH_coord_succ hκ c 0
  rw [h0] at hcoord
  simp only [lp.coeFn_zero, Pi.zero_apply] at hcoord
  have hshear : shear c 0 ≠ 0 := by
    have h2 : (0 : ℝ) < Real.sqrt 2 := by rw [Real.sqrt_pos]; norm_num
    have h1 : (0 : ℝ) < Real.sqrt (((0 : ℕ) : ℝ) + 1) := by rw [Real.sqrt_pos]; norm_num
    simp only [shear, ne_eq, mul_eq_zero, div_eq_zero_iff, not_or]
    exact ⟨⟨hc, ne_of_gt h2⟩, ne_of_gt h1⟩
  have hz : ((shear c 0 : ℝ) : ℂ) = 0 := by
    have h := hcoord.symm
    field_simp at h
    simpa using h
  exact hshear (by exact_mod_cast hz)
