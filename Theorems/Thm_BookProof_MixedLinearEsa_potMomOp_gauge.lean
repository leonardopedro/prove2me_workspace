-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.potMomOp_gauge
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.MixedLinearEsa



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]


theorem BookProof.MixedLinearEsa.potMomOp_gauge {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W) {m : V}
    (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0)
    (φ : 𝓢(V, ℂ)) (hφ : HasCompactSupport (φ : V → ℂ)) (x : V) :
    (potMomOp W m (phaseSchwartz hθ φ hφ)) x = phaseFun θ x * (momentumOp m φ x) := by sorry
