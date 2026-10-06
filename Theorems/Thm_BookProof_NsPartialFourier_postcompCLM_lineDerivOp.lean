-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.postcompCLM_lineDerivOp
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section


theorem BookProof.NsPartialFourier.postcompCLM_lineDerivOp (T : F →L[ℂ] G) (f : 𝓢(V, F)) (m : V) :
    postcompCLM T (∂_{m} f : 𝓢(V, F)) = (∂_{m} (postcompCLM T f) : 𝓢(V, G)) := by sorry
