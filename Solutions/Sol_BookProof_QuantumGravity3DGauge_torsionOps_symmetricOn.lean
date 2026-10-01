-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.torsionOps_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_realCoeff_torsionPoly
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
o spacetime indices. -/
theorem solution (mu nu a : Fin 4) :
    torsionPoly mu nu a = -torsionPoly nu mu a := by
  simp [torsionPoly]

/-- The `64` potential operators `T_{μν}^a` on the core, indexed by `Fin 64`. -/
def torsionOps (Φ : CoreRep 84 D) (m : Fin 64) : D →ₗ[ℂ] D :=
  Φ.op (mulOp (torsionPoly ⟨m.val / 16, by omega⟩ ⟨m.val / 4 % 4, by omega⟩
    ⟨m.val :=
   % 4, by omega⟩))
  
  theorem torsionOps_symmetri
