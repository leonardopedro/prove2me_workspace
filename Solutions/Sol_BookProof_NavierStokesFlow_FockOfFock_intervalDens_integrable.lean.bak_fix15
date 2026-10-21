-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.intervalDens_integrable
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_intervalDens_mul_extField_eq
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
theorem solution (j : ℕ) :
    Integrable (fun ξ => extField ξ * intervalDens j ξ) volume := by

  rw [intervalDens_mul_extField_eq, integrable_indicator_iff measurableSet_Ioc]
  exact (intervalIntegrable_iff_integrableOn_Ioc_of_le (by linarith)).1
    ((continuous_pow 2).intervalIntegrable _ _)
