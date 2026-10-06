-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.fourier_vecMomentumOp_apply
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable (V F) in
variable (V) in



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section


theorem BookProof.NsPartialFourier.fourier_vecMomentumOp_apply (m : V) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (vecMomentumOp m f) : 𝓢(V, F)) x
      = ((2 * Real.pi * (inner ℝ x m) : ℝ) : ℂ) • (𝓕 f : 𝓢(V, F)) x := by sorry
