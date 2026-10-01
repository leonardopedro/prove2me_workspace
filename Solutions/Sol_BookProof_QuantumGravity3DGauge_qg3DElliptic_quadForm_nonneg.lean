-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3DElliptic_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_quadForm_nonneg
import Theorems.Thm_BookProof_QuantumGravity3DGauge_torsionOps_symmetricOn
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgKappaElliptic_nonneg
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgMom_symmetricOn
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
ace operator with
the conformal direction's sign flipped to `+1/16`, i.e. the positive sum of squares to
which the Friedrichs machinery applies. -/
def qg3DEllipticHamiltonian (Φ : CoreRep 84 D) : D →ₗ[ℂ] L2d 84 :=
  signedOp qgKappaElliptic (qgMom Φ) (torsionOps Φ)

theorem solution (Φ : CoreRep 84 D) :
    SymmetricOn D (qg3 :=
  DEllipticHamiltonian Φ) :=
    signedOp_symmetricOn
