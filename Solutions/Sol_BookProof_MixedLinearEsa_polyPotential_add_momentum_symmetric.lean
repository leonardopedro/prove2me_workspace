-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.polyPotential_add_momentum_symmetric
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_potMomOp_symmetric
import Theorems.Thm_BookProof_MixedLinearEsa_hasTemperateGrowth_polyPotential
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (n : ℕ) (m : V) :
    SymmetricOn (schwartzDomain V) (opL2 (potMomOp (polyPotential c n m) m)) := potMomOp_symmetric _ (hasTemperateGrowth_polyPotential c n m) m
