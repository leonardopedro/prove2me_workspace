-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qgMomScaled_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

(qgMom_symmetricOn Φ)
    (torsionOps_symmetricOn Φ) x

theorem BookProof.QuantumGravity3DGauge.qgMomScaled_symmetricOn (Φ : CoreRep 84 D) :
    qg3DEllipticHamiltonian Φ
      = weylOp (fun j => ((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ j) (torsionOps Φ) :=
  signedOp_eq_weylOp qgKappa := by sorry
