-- Generated from ChapterQuantumGravityBrstCharge.lean — theorem BookProof.QuantumGravityBrstCharge.brst_abelian_nilpotent
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterQuantumGravity3DGauge
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent
open BookProof.QuantumGravityBrstCharge

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}



open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

theorem BookProof.QuantumGravityBrstCharge.brst_abelian_nilpotent (hCAR : GhostCAR χ β)
    (hcomm_chi : ∀ a b, G a * χ b = χ b * G a) (hcomm_beta : ∀ a b, G a * β b = β b * G a)
    (hab : ∀ a b, G a * G b = G b * G a) :
    glin G χ * glin G χ = 0 := by sorry
