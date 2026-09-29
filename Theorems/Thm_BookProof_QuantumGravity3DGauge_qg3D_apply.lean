-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qg3D_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

theorem BookProof.QuantumGravity3DGauge.qg3D_apply (Φ : CoreRep 84 D) (x : D) :
    qg3DHamiltonian Φ x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j, ((qgKappa j : ℝ) : ℂ) • ((qgMom Φ j (qgMom Φ j x) : D) : L2d 84))
            + ∑ m, ((torsionOps Φ m (torsionOps Φ m x) : D) : L2d 84)) := by sorry
