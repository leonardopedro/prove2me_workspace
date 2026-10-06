-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.integral_conj_mul_pos_sub_eq_zero
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_integrable_conj_schwartz_mul
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Theorems.Thm_BookProof_StrichartzWave_schwartzEquiv_coe
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (b : V) (z : ℂ) (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (posOp b) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (f : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (f x) * (((inner ℝ x b : ℝ) : ℂ) - z) * (u x) = 0 := by

  have h1 := hu (schwartzEquiv V f)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (f x) * (u x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul f u
  have hint2 : Integrable (fun x => (starRingEnd ℂ) ((posOp b f) x) * (u x))
      (volume : Measure V) := integrable_conj_schwartz_mul (posOp b f) u
  have hcomb : ∫ x, ((starRingEnd ℂ) ((posOp b f) x) * (u x)
      - z * ((starRingEnd ℂ) (f x) * (u x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [posOp_apply, map_mul, Complex.conj_ofReal]
  ring
