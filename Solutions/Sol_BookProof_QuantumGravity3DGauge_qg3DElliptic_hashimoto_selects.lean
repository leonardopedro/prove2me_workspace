-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3DElliptic_hashimoto_selects
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_torsionOps_symmetricOn
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qg3DElliptic_eq_weylOp
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgMomScaled_symmetricOn
import Theorems.Thm_BookProof_FriedrichsExtension_weyl_hashimoto_selects_friedrichs
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
theorem solution :
    ∃ (Dom : Submodule ℂ (L2d 84)) (A : Dom →ₗ[ℂ] L2d 84),
      IsPositiveSelfAdjointExtension (qg3DEllipticHamiltonian (coreRepPoly 84)) A :=
  te-mode domain of the orthonormal basis
  adapted to the Gauss–polynomial core. -/
  theorem qg3DElliptic_hashimoto_sele
