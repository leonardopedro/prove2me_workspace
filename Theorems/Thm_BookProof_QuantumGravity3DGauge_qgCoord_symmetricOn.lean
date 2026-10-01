-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qgCoord_symmetricOn
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

ultiplication by the
coordinate `x_j` (the tetrad fields `e_μ^a` and their derivative coordinates). -/
def qgCoord (Φ : CoreRep 84 D) (j : Fin 84) : D →ₗ[ℂ] D := Φ.op (mulOp (X j))

/-- The **momentum operators** `π_j = −i ∂/∂x_j` of the gravity field s := by sorry
