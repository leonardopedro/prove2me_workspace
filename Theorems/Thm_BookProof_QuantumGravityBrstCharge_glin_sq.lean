-- Generated from ChapterQuantumGravityBrstCharge.lean — theorem BookProof.QuantumGravityBrstCharge.glin_sq
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterQuantumGravity3DGauge
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.BRSTNilpotent
open BookProof.FreeFieldConstraint
open BookProof.QuantumGravityBrstCharge

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}



open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

theorem BookProof.QuantumGravityBrstCharge.glin_sq (hCAR : GhostCAR χ β) (hCA : ConstraintAlgebra f G χ β) :
    glin G χ * glin G χ = (1 / 2 : ℝ) • ∑ a, ∑ b, ∑ e, f a b e • (G e * (χ a * χ b)) := by sorry
