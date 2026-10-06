-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.posOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_posOp_deficiencyTrivialAt
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (b : V) :
    EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (posOp b)) := ⟨posOp_deficiencyTrivialAt b (by simp), posOp_deficiencyTrivialAt b (by simp)⟩
