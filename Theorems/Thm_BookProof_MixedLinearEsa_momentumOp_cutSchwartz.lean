-- Generated from ChapterMixedLinearEsa.lean — theorem BookProof.MixedLinearEsa.momentumOp_cutSchwartz
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.FourierMultiplierEsa
open BookProof.MixedLinearEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]



open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine


theorem BookProof.MixedLinearEsa.momentumOp_cutSchwartz (m : V) (g : V → ℝ) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgcs : HasCompactSupport g) (f : 𝓢(V, ℂ)) (x : V) :
    (momentumOp m (cutSchwartz g hg hgcs f)) x
      = -Complex.I * (f x * ((fderiv ℝ g x m : ℝ) : ℂ))
        + ((g x : ℝ) : ℂ) * (momentumOp m f x) := by sorry
