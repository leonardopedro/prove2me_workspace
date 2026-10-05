-- Generated from ChapterF8.lean — solution of BookProof.ChapterF8.featureHash_decodes
import Mathlib
import Definitions.Def_ChapterF8
open BookProof.ChapterF8



noncomputable section

open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution {k K : ℕ} (g : Fin k → Fin K) (hg : Function.Injective g)
    (y : Fin k → ℝ) (j : Fin k) :
    fockEmbed g y (Finsupp.single (g j) 1) = (y j : ℂ) := by

  classical
  rw [fockEmbed, Finsupp.finset_sum_apply]
  have hterm : ∀ i : Fin k,
      ((y i : ℂ) • Finsupp.single (Finsupp.single (g i) 1) (1 : ℂ)) (Finsupp.single (g j) 1)
        = if i = j then (y j : ℂ) else 0 := by
    intro i
    rw [Finsupp.smul_single, smul_eq_mul, mul_one, Finsupp.single_apply]
    by_cases hij : i = j
    · subst hij; simp
    · have hne : Finsupp.single (g i) 1 ≠ Finsupp.single (g j) (1 : ℕ) := by
        intro hc
        exact hij (hg (Finsupp.single_left_injective one_ne_zero hc))
      simp [hne, hij]
  rw [Finset.sum_congr rfl fun i _ => hterm i]
  simp
