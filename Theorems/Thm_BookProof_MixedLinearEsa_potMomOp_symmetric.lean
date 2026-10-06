-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.potMomOp_symmetric
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWaveUnboundedPotential
open BookProof.FourierMultiplierEsa
open BookProof.StrichartzWave
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


theorem BookProof.MixedLinearEsa.potMomOp_symmetric (W : V → ℝ) (hW : Function.HasTemperateGrowth W) (m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (potMomOp W m)) := by sorry
