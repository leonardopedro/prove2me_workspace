-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.normSq_sum_of_sectors
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_inner_toLp_eq_zero_of_ne_sector
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {D : Finset ℕ} (f : ℕ → FockAlg)
    (hf : ∀ n ∈ D, InSector n (f n)) :
    ‖toLp (∑ n ∈ D, f n)‖ ^ 2 = ∑ n ∈ D, ‖toLp (f n)‖ ^ 2 := by

  classical
  have hmap : toLp (∑ n ∈ D, f n) = ∑ n ∈ D, toLp (f n) := by
    rw [← toLpL_apply, map_sum]
    rfl
  have hinner : (inner ℂ (toLp (∑ n ∈ D, f n)) (toLp (∑ n ∈ D, f n)) : ℂ)
      = ∑ n ∈ D, ∑ m ∈ D, (inner ℂ (toLp (f n)) (toLp (f m)) : ℂ) := by
    rw [hmap, sum_inner]
    exact Finset.sum_congr rfl fun n _ => inner_sum _ _ _
  have hdiag : ∀ n ∈ D, ∑ m ∈ D, (inner ℂ (toLp (f n)) (toLp (f m)) : ℂ)
      = ((‖toLp (f n)‖ ^ 2 : ℝ) : ℂ) := by
    intro n hn
    rw [Finset.sum_eq_single n]
    · rw [inner_self_eq_norm_sq_to_K]
      norm_cast
    · intro m hm hmn
      exact inner_toLp_eq_zero_of_ne_sector (hf n hn) (hf m hm) (Ne.symm hmn)
    · intro hcon
      exact absurd hn hcon
  rw [Finset.sum_congr rfl hdiag] at hinner
  have hlhs : (inner ℂ (toLp (∑ n ∈ D, f n)) (toLp (∑ n ∈ D, f n)) : ℂ)
      = ((‖toLp (∑ n ∈ D, f n)‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [hlhs, ← Complex.ofReal_sum] at hinner
  exact_mod_cast hinner
