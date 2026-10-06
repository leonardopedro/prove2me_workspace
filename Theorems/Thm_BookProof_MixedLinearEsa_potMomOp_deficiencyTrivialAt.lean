-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.potMomOp_deficiencyTrivialAt
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterStrichartzWave
open BookProof.FourierMultiplierEsa
open BookProof.ShiftedHermiteCore
open BookProof.StrichartzWave
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


theorem BookProof.MixedLinearEsa.potMomOp_deficiencyTrivialAt {W θ : V → ℝ} (hW : Function.HasTemperateGrowth W)
    {m : V} (hθ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) θ)
    (hθd : ∀ x, HasDerivAt (fun t : ℝ => θ (x + t • m)) (-(W x)) 0)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (schwartzDomain V) (opL2 (potMomOp W m)) z := by sorry
