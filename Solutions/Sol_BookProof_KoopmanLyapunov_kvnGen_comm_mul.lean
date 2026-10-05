-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.kvnGen_comm_mul
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGen_apply
import Theorems.Thm_BookProof_YangMillsHermite_derOp_apply
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (G : Fin d → MvPolynomial (Fin d) ℂ) (E p : MvPolynomial (Fin d) ℂ) :
    kvnGen G (E * p) - E * kvnGen G p = (-Complex.I) • ((∑ i, G i * pderiv i E) * p) := by

  have hder : ∀ i : Fin d, derOp i (E * p) = pderiv i E * p + E * derOp i p := by
    intro i
    rw [derOp_apply, derOp_apply, pderiv_mul]
    simp only [MvPolynomial.smul_eq_C_mul]
    ring
  rw [kvnGen_apply, kvnGen_apply]
  have hsum : (∑ i, G i * derOp i (E * p))
      = (∑ i, G i * pderiv i E) * p + E * ∑ i, G i * derOp i p := by
    rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [hder i]; ring
  rw [hsum]
  simp only [mul_add, mul_smul_comm, smul_add]
  have e1 : (∑ i, pderiv i (G i)) * (E * p) = E * ((∑ i, pderiv i (G i)) * p) := by ring
  rw [e1]
  module
