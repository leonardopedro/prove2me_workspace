-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.partialFourier_inner
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



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section


theorem BookProof.NsPartialFourier.partialFourier_inner (v u : Lp F 2 (volume : Measure V)) :
    (inner ℂ (partialFourier V F v) (partialFourier V F u) : ℂ) = inner ℂ v u := by sorry
