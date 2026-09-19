-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3D_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_apply
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 84 D) (x : D) :
    qg3DHamiltonian Φ x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j, ((qgKappa j : ℝ) : ℂ) • ((qgMom Φ j (qgMom Φ j x) : D) : L2d 84))
            + ∑ m, ((torsionOps Φ m (torsionOps Φ m x) : D) : L2d 84)) := signedOp_apply qgKappa (qgMom Φ) (torsionOps Φ) x
