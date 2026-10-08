-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.polyPotential_add_momentum_symmetric
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.polyPotential_add_momentum_symmetric (c : ℕ → ℝ) (n : ℕ) (m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (potMomOp (polyPotential c n m) m)) := by sorry
