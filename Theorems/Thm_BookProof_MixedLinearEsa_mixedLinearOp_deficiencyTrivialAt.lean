-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.mixedLinearOp_deficiencyTrivialAt
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.FourierMultiplierEsa
open BookProof.StrichartzWave
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.mixedLinearOp_deficiencyTrivialAt (b m : V) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (schwartzDomain V) (opL2 (mixedLinearOp b m)) z := by sorry
