-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.bigState_symbol_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_momFock_total
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_bigState_coeFn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution {K : ℝ} (hK : 1 ≤ K) :
    ∀ᵐ x ∂fockR, ((bigState K : Lp ℂ 2 fockR) : ParcelConf ℝ → ℂ) x ≠ 0
        → K ≤ |momFock.total x| := by
  filter_upwards [bigState_coeFn K] with x hx hne
  rw [hx] at hne
  have hmem : x ∈ bigSet K := by

  filter_upwards [bigState_coeFn K] with x hx hne
  rw [hx] at hne
  have hmem : x ∈ bigSet K := by
    by_contra h
    exact hne (Set.indicator_of_notMem h _)
  obtain ⟨ξ, hξ, rfl⟩ := hmem
  have h0 : ξ 0 ∈ Set.Icc K (K + 1) := hξ 0 (Set.mem_univ 0)
  have ht : momFock.total (parcelMk 1 ξ) = (3 / 2) * (ξ 0) ^ 2 := by
    rw [momFock_total]
    show 3 / 2 * (∑ k : Fin 1, ξ k) ^ 2 = 3 / 2 * ξ 0 ^ 2
    rw [Fin.sum_univ_one]
  rw [ht, abs_of_nonneg (by positivity)]
  nlinarith [h0.1, hK]
