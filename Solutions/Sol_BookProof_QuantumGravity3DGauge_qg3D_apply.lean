-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3D_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_apply
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
zed, Weyl-ordered two-signed sum of squares
`H = ½ Σ_j κ_j π_j² + ½ Σ T²`, with the hyperbolic signature `qgKappa` produced by
`qg3DDensity_densitized` and the torsion-type potential ` :=
  torsionPoly`. -/
  def qg3DHamiltonian (Φ : CoreRep 84 D) : D →ₗ[ℂ] L2d
