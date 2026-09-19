-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3DElliptic_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_quadForm_nonneg
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgMom_symmetricOn
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgKappaElliptic_nonneg
import Theorems.Thm_BookProof_QuantumGravity3DGauge_torsionOps_symmetricOn
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 84 D) (x : D) :
    0 ≤ quadForm (qg3DEllipticHamiltonian Φ) x :=
  signedOp_quadForm_nonneg qgKappaElliptic_nonneg (qgMom_symmetricOn Φ)
      (torsionOps_symmetricOn Φ) x
