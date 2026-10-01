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

set_option maxHeartbeats 1000000 in
 {j : Fin 84} (hj : j ≠ confIndex) : 0 < qgKappa j := by
  simp [qgK :=
  appa, hj]
  
  /-- **The signature is
