-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_eq_weylOp
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_eq_weylOp (Φ : CoreRep 84 D) :
    qg3DEllipticHamiltonian Φ
      = weylOp (fun j => ((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ j) (torsionOps Φ) := by sorry
