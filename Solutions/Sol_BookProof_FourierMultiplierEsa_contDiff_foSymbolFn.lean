-- Generated from ChapterFourierMultiplierEsa.lean — solution of BookProof.FourierMultiplierEsa.contDiff_foSymbolFn
import Mathlib
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem solution (c : ι → ℝ) (w : ι → V) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (foSymbolFn c w) := by

  unfold foSymbolFn
  exact ContDiff.sum fun i _ => contDiff_const.mul (((innerSL ℝ).flip (w i)).contDiff)
