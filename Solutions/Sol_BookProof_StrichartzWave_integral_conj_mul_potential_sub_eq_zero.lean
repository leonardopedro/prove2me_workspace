-- Generated from ChapterWaveUnboundedPotential.lean — solution of BookProof.StrichartzWave.integral_conj_mul_potential_sub_eq_zero
import Mathlib
import Definitions.Def_ChapterWaveUnboundedPotential
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
import Theorems.Thm_BookProof_StrichartzWave_integrable_conj_schwartz_mul
import Theorems.Thm_BookProof_StrichartzWave_opL2_apply
import Theorems.Thm_BookProof_StrichartzWave_schwartzEquiv_coe
open BookProof.StrichartzWave




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace ENNReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (W : V → ℝ) (hW : Function.HasTemperateGrowth W)
    (z : ℂ) (u : Lp ℂ 2 (volume : Measure V))
    (hu : ∀ v : schwartzDomain V,
      (inner ℂ (opL2 (potentialOp W) v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : 𝓢(V, ℂ)) :
    ∫ x, (starRingEnd ℂ) (ψ x) * (((W x : ℝ) : ℂ) - z) * (u x) = 0 := by

  have h1 := hu (schwartzEquiv V ψ)
  rw [opL2_apply, schwartzEquiv_coe, inner_toLp_left, inner_toLp_left] at h1
  have hL : ∫ x, (starRingEnd ℂ) ((potentialOp W ψ) x) * (u x)
      = ∫ x, ((W x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (u x)) := by
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [potentialOp_apply hW, map_mul, Complex.conj_ofReal]
    ring
  rw [hL] at h1
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (ψ x) * (u x)) (volume : Measure V) :=
    integrable_conj_schwartz_mul ψ u
  have hint2 : Integrable (fun x => ((W x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (u x)))
      (volume : Measure V) := by
    have := integrable_conj_schwartz_mul (potentialOp W ψ) u
    refine this.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [potentialOp_apply hW, map_mul, Complex.conj_ofReal]
    ring
  have hcomb : ∫ x, (((W x : ℝ) : ℂ) * ((starRingEnd ℂ) (ψ x) * (u x))
      - z * ((starRingEnd ℂ) (ψ x) * (u x))) = 0 := by
    rw [integral_sub hint2 (hint1.const_mul z), MeasureTheory.integral_const_mul, h1]
    ring
  rw [← hcomb]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  ring
