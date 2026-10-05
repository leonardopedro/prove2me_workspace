-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.intervalSymbol_unbounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_intervalSymbol_eq
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
theorem solution :
    ∀ C : ℝ, ∃ j : ℕ, C < |symbolOfIntegral volume extField intervalDens j| := by
  intro C
  obtain ⟨j, hj⟩ := by

  intro C
  obtain ⟨j, hj⟩ := exists_nat_gt (max C 0)
  refine ⟨j, ?_⟩
  have hC : C < (j : ℝ) := lt_of_le_of_lt (le_max_left _ _) hj
  have hj0 : (0 : ℝ) ≤ (j : ℝ) := Nat.cast_nonneg j
  have hval : symbolOfIntegral volume extField intervalDens j
      = (((j : ℝ) + 1) ^ 3 - (j : ℝ) ^ 3) / 3 := intervalSymbol_eq j
  have hge : (j : ℝ) ≤ (((j : ℝ) + 1) ^ 3 - (j : ℝ) ^ 3) / 3 := by nlinarith
  have hpos : 0 ≤ (((j : ℝ) + 1) ^ 3 - (j : ℝ) ^ 3) / 3 := le_trans hj0 hge
  rw [hval, abs_of_nonneg hpos]
  linarith
