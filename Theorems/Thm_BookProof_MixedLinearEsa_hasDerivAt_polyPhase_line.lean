-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.hasDerivAt_polyPhase_line
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


theorem BookProof.MixedLinearEsa.hasDerivAt_polyPhase_line (c : ℕ → ℝ) (n : ℕ) {m : V} (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => polyPhase c n m (x + t • m)) (-(polyPotential c n m x)) 0 := by sorry
