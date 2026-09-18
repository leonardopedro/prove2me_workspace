-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.fockH_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_commForm_fockH
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) (x : maxDom (fockSym κ)) :
    |commForm (fockH hκ) (diagMax (fockSym κ)) x|
      ≤ (∑ i, (2 * κ i + 4 * κ i ^ 2)) * quadForm (diagMax (fockSym κ)) x := by

  have hmode : ∀ i : Fin d,
      |commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x|
        ≤ (2 * κ i + 4 * κ i ^ 2) * quadForm (diagMax (fockSym κ)) x := by
    intro i
    have h := ShiftData.shiftH_commForm_bound (modeData hκ i) x
    have hc : 2 * ((modeData hκ i).step) * (1 / 4 + (modeData hκ i).K)
        = 2 * κ i + 4 * κ i ^ 2 := by
      simp only [modeData]
      ring
    rw [hc] at h
    exact h
  calc |commForm (fockH hκ) (diagMax (fockSym κ)) x|
      = |∑ i, commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x| := by
        rw [commForm_fockH]
    _ ≤ ∑ i, |commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) x| :=
        Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ i, (2 * κ i + 4 * κ i ^ 2) * quadForm (diagMax (fockSym κ)) x :=
        Finset.sum_le_sum fun i _ => hmode i
    _ = (∑ i, (2 * κ i + 4 * κ i ^ 2)) * quadForm (diagMax (fockSym κ)) x := by
        rw [Finset.sum_mul]
