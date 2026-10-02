-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgMomScaled_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgMom_symmetricOn
import Theorems.Thm_BookProof_QuantumGravity3DGauge_smul_symmetricOn
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}

set_option maxHeartbeats 1000000 in
(qgMom_symmetricOn Φ)
    (torsionOps_symmetricOn Φ) x

theorem solution (Φ : CoreRep 84 D) :
    qg3DEllipticHamiltonian Φ
      = weylOp (fun j => ((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ j) (torsionOps Φ) :=
  signedOp_eq_weylOp qgKappa :=
  Elliptic_nonneg _ _
  
  theorem qgMomScaled_symmetricOn (Φ : CoreRep 84 D) (j : Fin 84) :
      SymmetricOn D (D.subtype.comp
        (((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ
