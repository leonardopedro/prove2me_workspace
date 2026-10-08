-- Generated from ChapterFourierMultiplierEsa.lean — solution of BookProof.FourierMultiplierEsa.contDiff_mixedSymbolFn
import Mathlib
import Definitions.Def_ChapterFourierMultiplierEsa
import Theorems.Thm_BookProof_FourierMultiplierEsa_contDiff_foSymbolFn
import Theorems.Thm_BookProof_StrichartzWave_contDiff_symbolFn
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
theorem solution (a c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (mixedSymbolFn a c w κ) := (contDiff_symbolFn c w κ).add (contDiff_foSymbolFn a w)
