-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.derOp_comm
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_pderiv_comm_poly
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    derOp j (derOp k p) = derOp k (derOp j p) := by

  classical
  have hjk : (pderiv j) (X k * p) = X k * pderiv j p + (if k = j then p else 0) := by
    rw [Derivation.leibniz]
    simp [MvPolynomial.pderiv_X, Pi.single_apply]
  have hkj : (pderiv k) (X j * p) = X j * pderiv k p + (if j = k then p else 0) := by
    rw [Derivation.leibniz]
    simp [MvPolynomial.pderiv_X, Pi.single_apply]
  have hcomm : (pderiv j) (pderiv k p) = (pderiv k) (pderiv j p) := pderiv_comm_poly j k p
  simp only [derOp_apply, map_sub, map_smul, hjk, hkj, hcomm]
  simp only [smul_eq_C_mul]
  by_cases h : j = k
  · subst h; ring
  · rw [if_neg h, if_neg (Ne.symm h)]; ring
