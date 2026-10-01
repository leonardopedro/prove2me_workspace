-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.mulHamiltonian_mulBasis
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) (n : ℕ) :
    (mulHamiltonian lam (mulBasis lam n) : L2Nat) = lp.single 2 n ((lam n : ℂ)) := by

  ext m
  by_cases hmn : m = n
  · subst hmn
    simp [mulHamiltonian, mulSymbolOp, mulBasis, mulSymbolFun, lp.single_apply]
  · simp [mulHamiltonian, mulSymbolOp, mulBasis, mulSymbolFun, lp.single_apply,
      Pi.single_eq_of_ne hmn]
