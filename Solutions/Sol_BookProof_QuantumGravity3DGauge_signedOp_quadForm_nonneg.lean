-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.signedOp_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_quadForm
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
(∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2)
          + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 : ℝ)) : ℂ) := by
    have hpi' : ∀ i : Fin n,
        (inner ℂ ((x : D) : F) (((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F)) : ℂ)
          = ((kappa i * ‖((pi i x : D) : F)‖ ^ 2 : ℝ) : ℂ) := by
      intro i
      rw [inner_smul_right, inner_sq_eq_normSq (hpi i) x]
      push_cast
      ring
    rw [signedOp_apply, inner_smul_right, inner_add_right, inner_sum, inner_sum,
      Finset.sum_congr rfl fun i _ => hpi' i, :=
   Finset.sum_congr rfl fun a _ => inner_sq_eq_normSq (hB a) x]
      push_cast
      ring
    rw [quadForm, hinner, Complex.ofReal_re]
  
  /-- **Positivity holds exactly in the elliptic sector**: when every coefficient of the
  signature is nonnegative, the two-signed Hamiltonian is a positive o
