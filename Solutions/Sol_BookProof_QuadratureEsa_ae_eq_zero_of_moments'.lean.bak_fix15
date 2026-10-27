-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.ae_eq_zero_of_moments'
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_fourier_eq_zero_of_moments
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {v : Vd d → ℂ}
    (hmeas : AEStronglyMeasurable v (volume : Measure (Vd d)))
    (hexp : ∀ c : ℝ, Integrable (fun x : Vd d => Real.exp (c * ‖x‖) * ‖v x‖))
    (hmom : ∀ p : MvPolynomial (Fin d) ℂ,
      ∫ x : Vd d, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p * v x = 0) :
    ∀ᵐ x : Vd d, v x = 0 := by

  have hint : Integrable v (volume : Measure (Vd d)) := by
    have h := hexp 0
    simp only [zero_mul, Real.exp_zero, one_mul] at h
    exact (integrable_norm_iff hmeas).mp h
  exact ae_eq_zero_of_fourier_eq_zero hint (fun w => fourier_eq_zero_of_moments hmeas hexp hmom w)
