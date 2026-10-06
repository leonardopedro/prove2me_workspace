-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.fourier_postcompCLM_apply
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section


theorem BookProof.NsPartialFourier.fourier_postcompCLM_apply [CompleteSpace F] [CompleteSpace G]
    (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) x = T ((𝓕 f : 𝓢(V, F)) x) := by sorry
