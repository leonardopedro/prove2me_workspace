-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.postcompCLM_lineDerivOp
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
theorem solution (T : F →L[ℂ] G) (f : 𝓢(V, F)) (m : V) :
    postcompCLM T (∂_{m} f : 𝓢(V, F)) = (∂_{m} (postcompCLM T f) : 𝓢(V, G)) := by

  ext x
  have hcoe : ((postcompCLM T f : 𝓢(V, G)) : V → G) = fun y => T (f y) :=
    funext fun y => postcompCLM_apply T f y
  have hf : HasFDerivAt (fun y => (f : V → F) y) (fderiv ℝ (f : V → F) x) x :=
    f.differentiableAt.hasFDerivAt
  have hT : HasFDerivAt (fun y => T (f y))
      ((T.restrictScalars ℝ).comp (fderiv ℝ (f : V → F) x)) x :=
    (T.restrictScalars ℝ).hasFDerivAt.comp x hf
  rw [postcompCLM_apply, lineDerivOp_apply_eq_fderiv, lineDerivOp_apply_eq_fderiv, hcoe,
    hT.fderiv]
  rfl
