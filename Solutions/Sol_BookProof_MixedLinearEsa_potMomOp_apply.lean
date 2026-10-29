-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.potMomOp_apply
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_momentumOp_apply
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterWaveUnboundedPotential
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine
open BookProof.FourierMultiplierEsa

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in

-- helpers copied from the source chapter, each with the source's `omit` so
-- their binders match the registered (omitted) statement of `potMomOp_apply`
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
private lemma hasTemperateGrowth_ofReal {W : V → ℝ} (hW : Function.HasTemperateGrowth W) :
    Function.HasTemperateGrowth (fun x => (W x : ℂ)) := by
  exact Function.HasTemperateGrowth.comp Complex.ofRealCLM.hasTemperateGrowth hW

omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] private theorem potentialOp_apply {W : V → ℝ} (hW : Function.HasTemperateGrowth W)
    (f : 𝓢(V, ℂ)) (x : V) : potentialOp W f x = (W x : ℂ) * f x := by
  simp [potentialOp, SchwartzMap.smulLeftCLM_apply_apply (hasTemperateGrowth_ofReal hW)]

-- the published `BookProof.MixedLinearEsa.momentumOp_apply` stub lost its
-- `omit` line, so it binds [FiniteDimensional] [MeasurableSpace] [BorelSpace]
-- and cannot be applied inside this (omitted) statement; use a private copy
-- that carries the source's `omit`.
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
@[simp] private theorem momOp_apply (m : V) (f : 𝓢(V, ℂ)) (x : V) :
    (momentumOp m f) x = (-Complex.I) * (fderiv ℝ f x m) := by
  simp [momentumOp, SchwartzMap.lineDerivOp_apply_eq_fderiv]

set_option maxHeartbeats 1000000 in
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in
theorem solution {W : V → ℝ} (hW : Function.HasTemperateGrowth W) (m : V) (f : 𝓢(V, ℂ))
    (x : V) :
    (potMomOp W m f) x = ((W x : ℝ) : ℂ) * f x + (-Complex.I) * (fderiv ℝ f x m) := by
  simp [potMomOp, potentialOp_apply hW, momOp_apply]
