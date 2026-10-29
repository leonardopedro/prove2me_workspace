-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.mixedLinearOp_apply
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_momentumOp_apply
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFourierMultiplierEsa
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine
open BookProof.FourierMultiplierEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

/-- Mirror copy of `ChapterMixedLinearEsa.hasTemperateGrowth_innerC` (dropped
from the published bundle). -/
private lemma hasTemperateGrowth_innerC' (b : V) :
    (fun x : V => ((inner ℝ x b : ℝ) : ℂ)).HasTemperateGrowth :=
  Complex.ofRealCLM.hasTemperateGrowth.comp ((innerSL ℝ).flip b).hasTemperateGrowth

/-- Mirror copy of `ChapterMixedLinearEsa.posOp_apply` (dropped from the
published bundle). -/
private lemma posOp_apply' (b : V) (f : 𝓢(V, ℂ)) (x : V) :
    (posOp b f) x = ((inner ℝ x b : ℝ) : ℂ) * f x := by
  simp [posOp, smulLeftCLM_apply_apply (hasTemperateGrowth_innerC' b)]

set_option maxHeartbeats 1000000 in

theorem solution (b m : V) (f : 𝓢(V, ℂ)) (x : V) :
    (mixedLinearOp b m f) x
      = ((inner ℝ x b : ℝ) : ℂ) * f x + (-Complex.I) * (fderiv ℝ f x m) := by
  simp [mixedLinearOp, momentumOp_apply, posOp_apply']
