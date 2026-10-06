-- Generated from ChapterNsPartialFourier.lean — solution of BookProof.NsPartialFourier.partialFourier_fibreOp
import Mathlib
import Definitions.Def_ChapterNsPartialFourier
import Theorems.Thm_BookProof_NsPartialFourier_fourier_postcompCLM
import Theorems.Thm_BookProof_NsPartialFourier_toLp_postcompCLM
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
theorem solution (T : F →L[ℂ] G) (f : Lp F 2 (volume : Measure V)) :
    partialFourier V G (fibreOp V T f) = fibreOp V T (partialFourier V F f) := by

  have hcont₁ : Continuous fun f : Lp F 2 (volume : Measure V) =>
      partialFourier V G (fibreOp V T f) :=
    (partialFourier V G).continuous.comp (fibreOp V T).continuous
  have hcont₂ : Continuous fun f : Lp F 2 (volume : Measure V) =>
      fibreOp V T (partialFourier V F f) :=
    (fibreOp V T).continuous.comp (partialFourier V F).continuous
  have hdense : Dense (Set.range (SchwartzMap.toLpCLM ℝ F 2 (volume : Measure V))) :=
    SchwartzMap.denseRange_toLpCLM (F := F) (μ := (volume : Measure V)) ENNReal.ofNat_ne_top
  refine congrFun (Continuous.ext_on hdense hcont₁ hcont₂ ?_) f
  rintro _ ⟨g, rfl⟩
  simp only [SchwartzMap.toLpCLM_apply, partialFourier_apply, fibreOp_apply]
  rw [← toLp_postcompCLM, SchwartzMap.toLp_fourier_eq, SchwartzMap.toLp_fourier_eq,
    ← toLp_postcompCLM, fourier_postcompCLM]
