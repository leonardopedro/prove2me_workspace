-- Generated from ChapterQuantumGravityBrstCharge.lean — theorem BookProof.QuantumGravityBrstCharge.glin_mul_Q_add_Q_mul_glin
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterQuantumGravity3DGauge
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent
open BookProof.QuantumGravityBrstCharge



open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}

theorem BookProof.QuantumGravityBrstCharge.glin_mul_Q_add_Q_mul_glin (hCAR : GhostCAR χ β) (hCA : ConstraintAlgebra f G χ β) :
    glin G χ * Q f χ β + Q f χ β * glin G χ
      = ∑ d, ∑ g, ∑ h, f d g h • (G h * (χ d * χ g)) := by sorry
