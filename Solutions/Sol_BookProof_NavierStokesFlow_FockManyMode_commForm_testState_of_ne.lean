-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.commForm_testState_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_modeShift_zero_ne_zero
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_modeShift_zero_inj
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
theorem solution (hκ : ∀ i, 0 ≤ κ i) {i i₀ : Fin d} (hne : i ≠ i₀) :
    commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) (testState κ i₀) = 0 := by

  classical
  have hshift : ∀ β : Occ d, (modeData hκ i).shift β = modeShift i β := fun _ => rfl
  have hzero : ∀ β : Occ d,
      2 * (modeData hκ i).step * ((modeData hκ i).amp β
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i).shift β)).re) = 0 := by
    intro β
    refine commTerm_eq_zero hκ i i₀ β ?_
    rw [hshift]
    rcases eq_or_ne β 0 with rfl | h0
    · have h2 : modeShift i (0 : Occ d) ≠ modeShift i₀ 0 := fun h => hne (modeShift_zero_inj h)
      rw [testState_coe_eq_zero i₀ (modeShift_zero_ne_zero i) h2, mul_zero]
    · rcases eq_or_ne β (modeShift i₀ 0) with rfl | h1
      · rw [testState_coe_eq_zero i₀ (modeShift_shift_ne i i₀) (modeShift_shift_ne' i i₀),
          mul_zero]
      · rw [testState_coe_eq_zero i₀ h0 h1, zero_mul]
  have hs := ShiftData.hasSum_commForm (modeData hκ i) (testState κ i₀)
  have hz : HasSum (fun β : Occ d =>
      2 * (modeData hκ i).step * ((modeData hκ i).amp β
        * ((starRingEnd ℂ) (((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) β)
          * ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ)
            ((modeData hκ i).shift β)).re)) 0 := by
    simp only [hzero]
    exact hasSum_zero
  exact hs.unique hz
