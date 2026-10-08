-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.postcompCLM_vecMomentumOp
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

theorem BookProof.NsPartialFourier.postcompCLM_vecMomentumOp (T : F →L[ℂ] G) (m : V) (f : 𝓢(V, F)) :
    postcompCLM T (vecMomentumOp m f) = vecMomentumOp m (postcompCLM T f) := by sorry
