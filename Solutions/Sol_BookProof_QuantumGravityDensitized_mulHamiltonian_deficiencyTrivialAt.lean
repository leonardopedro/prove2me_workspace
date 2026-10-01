-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.mulHamiltonian_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_QuantumGravityDensitized_mulHamiltonian_mulBasis
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (mulSymbolDomain lam) (mulHamiltonian lam) z := by

  intro w hw
  have hcoe : ∀ n : ℕ, ((w : L2Nat) : ℕ → ℂ) n = 0 := by
    intro n
    have h := hw (mulBasis lam n)
    rw [mulHamiltonian_mulBasis lam n] at h
    have hL : (inner ℂ (lp.single 2 n ((lam n : ℂ))) w : ℂ)
        = ((lam n : ℂ)) * ((w : L2Nat) : ℕ → ℂ) n := by
      rw [lp.inner_single_left]
      simp [mul_comm]
    have hR : (inner ℂ ((mulBasis lam n : L2Nat)) w : ℂ) = ((w : L2Nat) : ℕ → ℂ) n := by
      change (inner ℂ (lp.single 2 n (1 : ℂ)) w : ℂ) = _
      rw [lp.inner_single_left]
      simp
    rw [hL, hR] at h
    have hne : ((lam n : ℂ)) - z ≠ 0 := by
      intro hc
      have : z = ((lam n : ℝ) : ℂ) := by linear_combination -hc
      rw [this] at hz
      simp at hz
    have : (((lam n : ℂ)) - z) * ((w : L2Nat) : ℕ → ℂ) n = 0 := by linear_combination h
    exact (mul_eq_zero.mp this).resolve_left hne
  exact lp.ext (funext hcoe)
