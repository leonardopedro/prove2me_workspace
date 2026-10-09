-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3DElliptic_eq_weylOp
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_eq_weylOp
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgKappaElliptic_nonneg
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
theorem solution (Φ : CoreRep 84 D) (j : Fin 84) :
    SymmetricOn D (D.subtype.comp
      (((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ j)) := signedOp_quadForm_nonneg qgKappaElliptic_nonne
