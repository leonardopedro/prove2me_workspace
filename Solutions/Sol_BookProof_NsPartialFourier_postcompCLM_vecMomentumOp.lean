-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.postcompCLM_vecMomentumOp
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
import Theorems.Thm_BookProof_NsPartialFourier_postcompCLM_lineDerivOp
open BookProof.NsPartialFourier




open MeasureTheory SchwartzMap FourierTransform LineDeriv

noncomputable section

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {F G : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
  [NormedAddCommGroup G] [NormedSpace ℂ G]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable (V F) in
variable (V) in

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] G) (m : V) (f : 𝓢(V, F)) :
    postcompCLM T (vecMomentumOp m f) = vecMomentumOp m (postcompCLM T f) := by

  calc postcompCLM T (vecMomentumOp m f)
      = (-Complex.I) • postcompCLM T (∂_{m} f : 𝓢(V, F)) := by
        rw [vecMomentumOp_apply, map_smul]
    _ = vecMomentumOp m (postcompCLM T f) := by
        rw [postcompCLM_lineDerivOp, vecMomentumOp_apply]
