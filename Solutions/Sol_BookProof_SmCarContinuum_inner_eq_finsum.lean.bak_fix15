-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.inner_eq_finsum
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f g : Ell2} {J : Finset ℕ} (hf : ∀ i, (f : ℕ → ℂ) i ≠ 0 → i ∈ J) :
    (inner ℂ f g : ℂ) = ∑ i ∈ J, (starRingEnd ℂ) ((f : ℕ → ℂ) i) * (g : ℕ → ℂ) i := by

  rw [lp.inner_eq_tsum]
  rw [tsum_eq_sum (s := J) (f := fun i => (inner ℂ ((f : ℕ → ℂ) i) ((g : ℕ → ℂ) i) : ℂ))
    (fun i hi => by
      have hz : (f : ℕ → ℂ) i = 0 := by
        by_contra hne; exact hi (hf i hne)
      simp [RCLike.inner_apply, hz])]
  exact Finset.sum_congr rfl fun i _ => by simp [RCLike.inner_apply, mul_comm]
