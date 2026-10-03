-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgCoord_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X
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
theorem solution (Φ : CoreRep 84 D) (j k : Fin 84) (x : D) :
    qgCoord Φ j (qgMom Φ k x) - qgMom Φ k (qgCoord Φ j x)
      = (if j = k then Complex.I else 0) • x :=
  pace (F.3). -/
  def qgMom (Φ : CoreRep 84 D) (j : Fin 84) : D →ₗ[ℂ] D :=
