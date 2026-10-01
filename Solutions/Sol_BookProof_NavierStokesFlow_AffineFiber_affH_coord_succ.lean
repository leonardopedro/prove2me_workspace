-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.affH_coord_succ
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_shift_of_single
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_hFun_eq_zero
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_PairShift_pairH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_basisState_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 ≤ c) (n : ℕ) :
    ((affH hκ hc (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 1)
      = Complex.I * ((shear c n : ℝ) : ℂ) := by

  have hX := basisState_coe κ c n
  have hfst : (affData hκ hc).fst.hFun ((basisState κ c n : L2I ℕ) : ℕ → ℂ) (n + 1) = 0 := by
    refine hFun_eq_zero _ (fun α hα => ?_) ?_
    · simp only [affData_shift₁] at hα
      rw [hX]
      have : α ≠ n := by omega
      simp [this]
    · simp only [PairShift.fst_shift, affData_shift₁, hX]
      norm_num
      omega
  have hsnd : (affData hκ hc).snd.hFun ((basisState κ c n : L2I ℕ) : ℕ → ℂ) (n + 1)
      = Complex.I * ((shear c n : ℝ) : ℂ) := by
    have h := hFun_shift_of_single (affData hκ hc).snd
      (X := ((basisState κ c n : L2I ℕ) : ℕ → ℂ)) (o := n)
      (by simp [hX]) (by simp [hX]; omega)
    simpa using h
  change ((PairShift.pairH (affData hκ hc) (basisState κ c n) : L2I ℕ) : ℕ → ℂ) (n + 1) = _
  have hp1 := PairShift.pairH_coe (P := affData 
