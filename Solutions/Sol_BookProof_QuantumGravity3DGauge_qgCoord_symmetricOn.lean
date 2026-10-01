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

set_option maxHeartbeats 1000000 in
ultiplication by the
coordinate `x_j` (the tetrad fields `e_μ^a` and their derivative coordinates). -/
def qgCoord (Φ : CoreRep 84 D) (j : Fin 84) : D →ₗ[ℂ] D := Φ.op (mulOp (X j))

/-- The **momentum operators** `π_j = −i ∂/∂x_j` of the gravity field s :=
  pace (F.3). -/
  def qgMom (Φ : CoreRep 84 D) (j : Fin 84) : D →ₗ[ℂ] D :=
