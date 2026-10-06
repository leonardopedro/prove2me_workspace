-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.scale_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution (x : X) : 0 ≤ S.scale x := by

  have h1 : (0 : ℝ) ≤ ∑ i : Fin 3, |S.P i x| := Finset.sum_nonneg fun i _ => abs_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ i : Fin 3, |S.Q i x| := Finset.sum_nonneg fun i _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ i : Fin 3, |S.Dr i x| := Finset.sum_nonneg fun i _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith
