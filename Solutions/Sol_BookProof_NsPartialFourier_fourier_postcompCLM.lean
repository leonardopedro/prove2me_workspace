-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.fourier_postcompCLM
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
import Theorems.Thm_BookProof_NsPartialFourier_fourier_postcompCLM_apply
open BookProof.NsPartialFourier




open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] [CompleteSpace G] (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) = postcompCLM T (𝓕 f : 𝓢(V, F)) := by

  ext x
  simpa using fourier_postcompCLM_apply T f x
