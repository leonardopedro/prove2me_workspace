-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgKappa_indefinite
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_idxX_ne_idxE
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgKappa_spatial_pos
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgKappa_conformal_neg
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
theorem solution : (∃ j, 0 < qgKappa j) ∧ ∃ j, qgKappa j < 0 :=
  appa, hj]
  
  /-- **The signature is
