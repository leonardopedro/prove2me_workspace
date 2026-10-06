-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.opL2_add
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


theorem BookProof.MixedLinearEsa.opL2_add (A B : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) : opL2 (A + B) = opL2 A + opL2 B := by sorry
