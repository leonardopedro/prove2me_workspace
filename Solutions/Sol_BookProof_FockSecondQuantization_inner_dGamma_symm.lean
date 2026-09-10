-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.inner_dGamma_symm
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_left
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_right
import Theorems.Thm_BookProof_FockSecondQuantization_modes_left_subset_closure
import Theorems.Thm_BookProof_FockSecondQuantization_modes_right_subset_closure
import Theorems.Thm_BookProof_FockSecondQuantization_col_support_subset_closure
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) (u v : FockAlg) :
    (inner ℂ (toLp (dGamma col u)) (toLp v) : ℂ) = inner ℂ (toLp u) (toLp (dGamma col v)) := by

  rw [inner_dGamma_left col u v (modes_left_subset_closure col u v)
      (col_support_subset_closure col u v),
    inner_dGamma_right col u v (modes_right_subset_closure col u v)
      (col_support_subset_closure col u v),
    Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
  rw [hherm j k, Complex.conj_conj]
