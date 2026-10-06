-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.toLp_postcompCLM
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
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
theorem solution (T : F →L[ℂ] G) (f : 𝓢(V, F)) :
    (postcompCLM T f).toLp 2 (volume : Measure V)
      = T.compLp (f.toLp 2 (volume : Measure V)) := by

  refine (MeasureTheory.Lp.ext_iff).2 ?_
  filter_upwards [(postcompCLM T f).coeFn_toLp 2 (volume : Measure V),
    T.coeFn_compLp (f.toLp 2 (volume : Measure V)),
    f.coeFn_toLp 2 (volume : Measure V)] with x hx hTx hfx
  rw [hx, hTx, hfx, postcompCLM_apply]
