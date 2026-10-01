-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

ace operator with
the conformal direction's sign flipped to `+1/16`, i.e. the positive sum of squares to
which the Friedrichs machinery applies. -/
def qg3DEllipticHamiltonian (Φ : CoreRep 84 D) : D →ₗ[ℂ] L2d 84 :=
  signedOp qgKappaElliptic (qgMom Φ) (torsionOps Φ)

theorem BookProof.QuantumGravity3DGauge.qg3DElliptic_quadForm_nonneg (Φ : CoreRep 84 D) :
    SymmetricOn D (qg3 := by sorry
