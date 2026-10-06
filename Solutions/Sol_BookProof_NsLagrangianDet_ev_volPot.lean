-- Generated from ChapterNsLagrangianDetConvolution.lean — solution of BookProof.NsLagrangianDet.ev_volPot
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Theorems.Thm_BookProof_NsLagrangianDet_ev_conjP
open BookProof.NsLagrangianDet




open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]

set_option maxHeartbeats 1000000 in
theorem solution (kappa : ℝ) (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) :
    ev y (volPot kappa kv)
      = ((kappa / 2 * ∑ q ∈ waveSet kv, Complex.normSq (ev y (volCoef kv q)) : ℝ) : ℂ) := by

  rw [volPot, MvPolynomial.smul_eq_C_mul, map_mul, map_sum]
  simp only [map_mul, ev_conjP]
  rw [show ev y (C ((kappa / 2 : ℝ) : ℂ)) = ((kappa / 2 : ℝ) : ℂ) by simp [ev]]
  push_cast
  congr 1
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [Complex.normSq_eq_conj_mul_self]
