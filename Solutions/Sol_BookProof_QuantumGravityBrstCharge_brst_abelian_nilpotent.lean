-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.brst_abelian_nilpotent
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_glin_sq
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hCAR : GhostCAR χ β)
    (hcomm_chi : ∀ a b, G a * χ b = χ b * G a) (hcomm_beta : ∀ a b, G a * β b = β b * G a)
    (hab : ∀ a b, G a * G b = G b * G a) :
    glin G χ * glin G χ = 0 := by

  have hCA : ConstraintAlgebra (fun _ _ _ => (0 : ℝ)) G χ β :=
    { comm_chi := hcomm_chi
      comm_beta := hcomm_beta
      bracket := by intro a b; simp [hab a b] }
  have h := glin_sq (f := fun _ _ _ => (0 : ℝ)) hCAR hCA
  simpa using h
