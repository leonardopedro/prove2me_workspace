-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3D_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_symmetricOn
import Theorems.Thm_BookProof_QuantumGravity3DGauge_torsionOps_symmetricOn
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgMom_symmetricOn
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
theorem solution (Φ : CoreRep 84 D) (x : D) :
    quadForm (qg3DHamiltonian Φ) x
      = 1 / 2 * (∑ j, qgKappa j * ‖((qgMom Φ j x : D) : L2d 84)‖ ^ 2)
        + 1 / 2 * ∑ m, ‖((torsionOps Φ m x : D) : L2d 84)‖ ^ 2 :=
  bolic) signature. -/
  theorem qg3D_symmetricOn (Φ : CoreRep 84 D) : Symmetr
