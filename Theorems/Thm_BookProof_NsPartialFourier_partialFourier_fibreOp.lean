-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.partialFourier_fibreOp
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

theorem BookProof.NsPartialFourier.partialFourier_fibreOp (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    partialFourier V G (fibreOp V T f) = fibreOp V T (partialFourier V F f) := by sorry
