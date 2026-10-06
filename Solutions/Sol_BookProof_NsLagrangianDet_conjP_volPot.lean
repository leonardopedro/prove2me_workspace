-- Generated from ChapterNsLagrangianDetConvolution.lean — solution of BookProof.NsLagrangianDet.conjP_volPot
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet




open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]

set_option maxHeartbeats 1000000 in
theorem solution (kappa : ℝ) (kv : K → Fin 3 → ℝ) :
    conjP (volPot kappa kv) = volPot kappa kv := by

  have hcc : ∀ p : MvPolynomial (DIdx K) ℂ, conjP (conjP p) = p := by
    intro p
    rw [conjP, conjP, MvPolynomial.map_map]
    have : (starRingEnd ℂ).comp (starRingEnd ℂ) = RingHom.id ℂ := by
      ext z; simp
    rw [this, MvPolynomial.map_id]
  rw [volPot, conjP, MvPolynomial.smul_eq_C_mul, map_mul, map_C, map_sum, Complex.conj_ofReal]
  congr 1
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [map_mul]
  change conjP (conjP _) * conjP _ = _
  rw [hcc, mul_comm]
