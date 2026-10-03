-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.commute_mul_mul
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momOp j (momOp k p) = momOp k (momOp j p) := momOp j (mo
