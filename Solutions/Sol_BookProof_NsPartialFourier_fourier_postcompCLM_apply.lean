-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.fourier_postcompCLM_apply
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
theorem solution [CompleteSpace F] [CompleteSpace G]
    (T : F →L[ℂ] G) (f : 𝓢(V, F)) (x : V) :
    (𝓕 (postcompCLM T f) : 𝓢(V, G)) x = T ((𝓕 f : 𝓢(V, F)) x) := by

  rw [SchwartzMap.fourier_coe, SchwartzMap.fourier_coe, Real.fourier_eq, Real.fourier_eq]
  have hint : Integrable (fun v : V => (𝐞 (-inner ℝ v x) : ℂ) • f v) volume :=
    (Real.fourierIntegral_convergent_iff _).mpr f.integrable
  have h := ContinuousLinearMap.integral_comp_comm (T.restrictScalars ℝ) hint
  simp only [ContinuousLinearMap.coe_restrictScalars'] at h
  simp only [Circle.smul_def]
  rw [← h]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  simp
