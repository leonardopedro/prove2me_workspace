-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_coord_succ_succ
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_basisState_coe
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_shift_of_single
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) (n : ℕ) :
    ((saffH hκ c (basisState κ |c| n) : L2I ℕ) : ℕ → ℂ) (n + 2)
      = Complex.I * ((amp κ n : ℝ) : ℂ) := by

  have hX := basisState_coe κ |c| n
  have hsnd : (affData hκ (abs_nonneg c)).snd.hFun
      ((basisState κ |c| n : L2I ℕ) : ℕ → ℂ) (n + 2) = 0 := by
    refine hFun_eq_zero _ (fun α hα => ?_) ?_
    · simp only [affData_shift₂] at hα
      rw [hX]
      have : α ≠ n := by omega
      simp [this]
    · simp only [PairShift.snd_shift, affData_shift₂, hX]
      norm_num
      omega
  have hfst : (affData hκ (abs_nonneg c)).fst.hFun
      ((basisState κ |c| n : L2I ℕ) : ℕ → ℂ) (n + 2)
      = Complex.I * ((amp κ n : ℝ) : ℂ) := by
    have h := hFun_shift_of_single (affData hκ (abs_nonneg c)).fst
      (X := ((basisState κ |c| n : L2I ℕ) : ℕ → ℂ)) (o := n)
      (by simp [hX]) (by simp [hX]; omega)
    simpa using h
  rw [saffH_coe, hfst, hsnd, mul_zero, add_zero]
