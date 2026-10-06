-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.hasDerivAt_gaugeFun_line
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_hasDerivAt_gaugePhase_line
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem solution (b m : V) (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => gaugeFun b m (x + t • m))
      (gaugeFun b m x * (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ))) 0 := by

  have h := hasDerivAt_gaugePhase_line b m hm x
  have h1 : HasDerivAt (fun t : ℝ => ((gaugePhase b m (x + t • m) : ℝ) : ℂ))
      (((-(inner ℝ x b : ℝ) : ℝ) : ℂ)) 0 := h.ofReal_comp
  have h2 : HasDerivAt (fun t : ℝ => Complex.I * ((gaugePhase b m (x + t • m) : ℝ) : ℂ))
      (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ)) 0 := h1.const_mul _
  simpa [gaugeFun] using h2.cexp
