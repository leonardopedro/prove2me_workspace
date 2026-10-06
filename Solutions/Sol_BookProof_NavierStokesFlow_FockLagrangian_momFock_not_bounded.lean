-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.momFock_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_norm_bigState
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_bigState_mem_core
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_bigState_symbol_ge
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_hFull_eq_mulD
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ v : momFock.core,
      ‖((momFock.data.hFull v : momFock.core) : Lp ℂ 2 fockR)‖
        ≤ C * ‖((v : momFock.core) : Lp ℂ 2 fockR)‖ := by

  simp only [momFock.hFull_eq_mulD]
  refine mulD_not_bounded _ _ _ fun K => ?_
  refine ⟨⟨bigState (max K 1), bigState_mem_core (le_trans zero_le_one (le_max_right K 1))⟩,
    norm_bigState _, ?_⟩
  filter_upwards [bigState_symbol_ge (le_max_right K 1)] with x hx hne
  exact le_trans (le_max_left K 1) (hx hne)
