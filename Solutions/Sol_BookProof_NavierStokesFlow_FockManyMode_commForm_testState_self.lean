-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.commForm_testState_self
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_modeShift_zero_ne_zero
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_testState_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_testState_coe_zero
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_testState_coe_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_modeShift_shift_ne
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_modeShift_shift_ne'
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_commTerm_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_SignedHop_hasSum_commForm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) (i₀ : Fin d) :
    commForm (ShiftData.shiftH (modeData hκ i₀)) (diagMax (fockSym κ)) (testState κ i₀)
      = 2 * (4 * κ i₀) * modeAmp κ i₀ 0 := by

  classical
  have hshift : ∀ β : Occ d, (modeData hκ i₀).shift β = modeShift i₀ β := fun _ => rfl
  have hs := ShiftData.hasSum_commForm (modeData hκ i₀) (testState κ i₀)
  simp only [modeData_sym] at hs
  have hsingle : HasSum (fun β : Occ d =>
      2 * (modeData hκ i₀).step * ((modeData hκ i₀).amp β
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i₀).shift β)).re))
      (2 * (modeData hκ i₀).step * ((modeData hκ i₀).amp 0
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) 0)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i₀).shift 0)).re)) := by
    refine hasSum_single 0 fun β hβ => ?_
    refine commTerm_eq_zero hκ i₀ i₀ β ?_
    rw [hshift]
    rcases eq_or_ne β (modeShift i₀ 0) with rfl | h1
    · rw [testState_coe_eq_zero i₀ (modeShift_shift_ne i₀ i₀) (modeShift_shift_ne' i₀ i₀),
        mul_zero]
    · rw [testState_coe_eq_zero i₀ hβ h1, zero_mul]
  rw [hs.unique hsingle]
  have hshift0 : (modeData hκ i₀).shift 0 = modeShift i₀ 0 := rfl
  have hamp0 : (modeData hκ i₀).amp 0 = modeAmp κ i₀ 0 := rfl
  have hstep : (modeData hκ i₀).step = 4 * κ i₀ := rfl
  have hc0 : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) 0 = 1 := testState_coe_zero i₀
  have hc1 : ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) (modeShift i₀ 0) = 1 := by
    rw [testState_coe, if_neg (modeShift_zero_ne_zero i₀), if_pos rfl]
  rw [hshift0, hamp0, hstep, hc0, hc1]
  simp
