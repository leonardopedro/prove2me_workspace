-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.linGen_smul_sum
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (c : Fin n → ℝ) (M : Fin n → Matrix (Fin d) (Fin d) ℝ) :
    linGen (∑ e, c e • M e) = ∑ e, c e • linGen (M e) := by

  rw [linGen, map_sum]
  exact Finset.sum_congr rfl fun e _ => map_smul linGenLM (c e) (M e)
