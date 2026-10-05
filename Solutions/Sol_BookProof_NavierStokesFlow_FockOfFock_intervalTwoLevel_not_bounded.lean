-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.intervalTwoLevel_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_confEnergy_zero
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_not_bounded
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_intervalSymbol_unbounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {K : Type*} [DecidableEq K]

set_option maxHeartbeats 1000000 in
theorem solution (eps : K → ℝ) :
    ¬ ∃ C : ℝ, ∀ f : FockOfFockDom ℕ K,
      ‖dGamma (intervalTwoLevelSymbol eps) f‖ ≤ C * ‖f‖ := by

  refine dGamma_not_bounded _ fun C => ?_
  obtain ⟨j, hj⟩ := intervalSymbol_unbounded C
  refine ⟨(j, 0), ?_⟩
  simpa [intervalTwoLevelSymbol, confEnergy_zero] using hj
