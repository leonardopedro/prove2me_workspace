-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.ccr_poly
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_YangMillsHermite_commutator_coord_mom
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulOp (X j) (momOp k p) - momOp k (mulOp (X j) p) = (if j = k then Complex.I else 0) • p := by

  by_cases h : j = k
  · subst h
    simpa using commutator_coord_mom j p
  · have hX : (pderiv k) (X j * p) = X j * pderiv k p := by
      rw [Derivation.leibniz]
      simp [MvPolynomial.pderiv_X, Ne.symm h]
    simp only [mulOp_apply, momOp_apply, hX, if_neg h, zero_smul, neg_smul, smul_eq_C_mul]
    ring
