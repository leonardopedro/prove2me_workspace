-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.fibreOp_apply
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

omit [CompleteSpace F] [CompleteSpace G] in
theorem BookProof.NsPartialFourier.fibreOp_apply (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    fibreOp V T f = T.compLp f := by sorry
