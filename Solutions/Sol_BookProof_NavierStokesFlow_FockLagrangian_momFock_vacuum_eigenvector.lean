-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.momFock_vacuum_eigenvector
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_momFock_total
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_vacState_coeFn
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_vacState_mem_core
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_hFull_eq_mulD
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_meas
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution :
    ((momFock.data.hFull ⟨vacState, vacState_mem_core⟩ : momFock.core) : Lp ℂ 2 fockR) = 0 := by

  have key : ((mulD fockR momFock.total_meas momFock.total_dom
      ⟨vacState, vacState_mem_core⟩ : boundedEnergyCore fockR momFock.scale) :
      Lp ℂ 2 fockR) = 0 := by
    refine Lp.ext ?_
    filter_upwards [mulD_coeFn fockR momFock.total_meas momFock.total_dom
        (⟨vacState, vacState_mem_core⟩ : boundedEnergyCore fockR momFock.scale),
      vacState_coeFn, Lp.coeFn_zero (E := ℂ) (p := 2) (μ := fockR)] with x hmul hx hz
    rw [hmul, hz]
    by_cases hmem : x ∈ vacSet
    · obtain ⟨ξ, -, rfl⟩ := hmem
      have h0 : momFock.total (parcelMk 0 ξ) = 0 := by
        rw [momFock_total]
        show 3 / 2 * (∑ k : Fin 0, ξ k) ^ 2 = 0
        simp
      rw [h0]
      simp
    · rw [hx, Set.indicator_of_notMem hmem]
      simp
  rw [momFock.hFull_eq_mulD]
  exact key
