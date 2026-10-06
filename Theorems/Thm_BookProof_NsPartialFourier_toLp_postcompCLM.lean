-- Generated from ChapterNsPartialFourier.lean — theorem BookProof.NsPartialFourier.toLp_postcompCLM
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
open BookProof.NsPartialFourier

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]



open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section


theorem BookProof.NsPartialFourier.toLp_postcompCLM (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (postcompCLM T f).toLp 2 (volume : Measure V)
      = T.compLp (f.toLp 2 (volume : Measure V)) := by sorry
