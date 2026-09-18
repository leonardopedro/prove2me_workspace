-- Generated from ChapterNavierStokesFockManyMode.lean — solution of BookProof.NavierStokesFlow.FockManyMode.fock_commForm_ne_zero
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_commForm_fockH
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_commForm_testState_of_ne
import Theorems.Thm_BookProof_NavierStokesFlow_FockManyMode_commForm_testState_self
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode



open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian


variable {d : ℕ} {κ : Fin d → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hκ : ∀ i, 0 ≤ κ i) (i₀ : Fin d) (hpos : 0 < κ i₀) :
    commForm (fockH hκ) (diagMax (fockSym κ)) (testState κ i₀) ≠ 0 := by

  classical
  rw [commForm_fockH]
  rw [Finset.sum_eq_single i₀ (fun i _ hne => commForm_testState_of_ne hκ hne)
    (fun h => absurd (Finset.mem_univ i₀) h), commForm_testState_self]
  have hamp : 0 < modeAmp κ i₀ 0 := by
    have h : (0 : ℝ) < Real.sqrt ((((0 : Occ d) i₀ : ℝ) + 1) * (((0 : Occ d) i₀ : ℝ) + 2)) := by
      rw [Real.sqrt_pos]
      norm_num
    simp only [modeAmp]
    positivity
  positivity
