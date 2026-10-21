-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.potMomOp_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_potMomOp_deficiencyTrivialAt
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W)
    {m : V} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0) :
    EssentiallySelfAdjointOn (schwartzDomain V) (opL2 (potMomOp W m)) :=
  ⟨potMomOp_deficiencyTrivialAt hW hθ hθd (by simp),
      potMomOp_deficiencyTrivialAt hW hθ hθd (by simp)⟩
