import Mathlib

/-!
# Chapter E (continued) — Euler's formula for a generic phase-space

This file formalizes the mathematical content of the `book.tex` sections
*"Euler's formula for a phase-space with 4 states"* and *"Euler's formula for a
generic phase-space"* (Chapter *"Wave-function collapse versus Euler's formula"*,
`book.tex` line ~3565), extending `BookProof/ChapterE.lean` (which handled the
2-state clock).

The book parametrizes a real normalized wave-function of an `n`-state (or
countable) phase-space by *Euler angles* `θ₁, θ₂, …` via the recursion
`vₙ = cos(θₙ) lₙ + sin(θₙ) vₙ₊₁`, and observes that the resulting Born
probabilities are

```
P(1) = c₁²,   P(2) = (s₁ c₂)²,   P(3) = (s₁ s₂ c₃)²,   …
```

i.e. a *stick-breaking* construction with conditional "stop-here" probability
`cₖ² = cos²(θₖ)` and conditional "go-higher" probability `sₖ² = sin²(θₖ)`.  The
book's point is twofold:

* these are a genuine probability distribution (they are nonnegative and sum to
  `1`), and
* **every** probability distribution on `n` states is realized this way (the
  conditional probabilities `cos²(θₖ)` are arbitrary, so the distribution is
  arbitrary) — "any probability distribution can be reproduced by the Born rule
  for some wave-function".

We model the angles by a function `θ : ℕ → ℝ` (values outside the relevant range
are irrelevant), which avoids `Fin`-index arithmetic.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators
open Finset

namespace BookProof.ChapterE2

/-- The Born probability of "stopping exactly at index `n`":
`(∏_{k<n} sin²θₖ) · cos²θₙ`. -/
noncomputable def stick (θ : ℕ → ℝ) (n : ℕ) : ℝ :=
  (∏ k ∈ range n, Real.sin (θ k) ^ 2) * Real.cos (θ n) ^ 2

/-- The "`N` or above" remaining probability after `N` steps: `∏_{k<N} sin²θₖ`. -/
noncomputable def remainder (θ : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∏ k ∈ range N, Real.sin (θ k) ^ 2

/-- The Born distribution of an `n`-state phase-space: stopping probabilities at
`0, …, n-2` and the remainder at the last index `n-1`. -/
noncomputable def bornProb (θ : ℕ → ℝ) (n : ℕ) (i : Fin n) : ℝ :=
  if (i : ℕ) + 1 < n then stick θ (i : ℕ) else remainder θ (i : ℕ)

/-! ## Basic identities -/

theorem remainder_zero (θ : ℕ → ℝ) : remainder θ 0 = 1 := by
  simp [remainder]

theorem remainder_succ (θ : ℕ → ℝ) (N : ℕ) :
    remainder θ (N + 1) = remainder θ N * Real.sin (θ N) ^ 2 := by
  simp [remainder, Finset.prod_range_succ]

theorem stick_eq (θ : ℕ → ℝ) (n : ℕ) :
    stick θ n = remainder θ n * Real.cos (θ n) ^ 2 := by
  rfl

theorem stick_nonneg (θ : ℕ → ℝ) (n : ℕ) : 0 ≤ stick θ n := by
  apply mul_nonneg
  · exact Finset.prod_nonneg (fun _ _ => sq_nonneg _)
  · exact sq_nonneg _

theorem remainder_nonneg (θ : ℕ → ℝ) (N : ℕ) : 0 ≤ remainder θ N :=
  Finset.prod_nonneg (fun _ _ => sq_nonneg _)

theorem remainder_le_one (θ : ℕ → ℝ) (N : ℕ) : remainder θ N ≤ 1 := by
  exact Finset.prod_le_one ( fun _ _ => sq_nonneg _ ) fun _ _ => Real.sin_sq_le_one _

/-! ## Normalization (the telescoping identity) -/

/-
**Telescoping normalization.** The partial sum of the stopping probabilities
plus the remainder equals `1`.  (Because `stick θ N = remainder θ N · cos²θ_N`
and `remainder θ (N+1) = remainder θ N · sin²θ_N`, with `cos² + sin² = 1`.)
-/
theorem sum_stick_add_remainder (θ : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ range N, stick θ n) + remainder θ N = 1 := by
  induction N with
  | zero => ?_
  | succ N ih => ?_
  · norm_num [ remainder ];
  · simp_all only [sum_range_succ, remainder_succ];
    rw [ ← ih, stick_eq ] ; rw [ Real.sin_sq ] ; ring

/-! ## The Born family is a probability distribution -/

theorem bornProb_nonneg (θ : ℕ → ℝ) (n : ℕ) (i : Fin n) : 0 ≤ bornProb θ n i := by
  unfold bornProb
  split
  · exact stick_nonneg θ _
  · exact remainder_nonneg θ _

/-
**The Born distribution of an `n`-state phase-space sums to `1`.**
-/
theorem bornProb_sum_eq_one (θ : ℕ → ℝ) (n : ℕ) (hn : 1 ≤ n) :
    ∑ i : Fin n, bornProb θ n i = 1 := by
  rcases n with ( _ | _ | n ) <;> simp_all only [nonpos_iff_eq_zero, one_ne_zero, zero_add, le_refl,
      Nat.reduceAdd, univ_unique, Fin.default_eq_zero, Fin.isValue, sum_singleton,
          le_add_iff_nonneg_left, zero_le, Fin.sum_univ_castSucc];
  · unfold bornProb; aesop;
  · convert sum_stick_add_remainder θ ( n + 1 ) using 1;
    simp [ Finset.sum_range, Fin.sum_univ_castSucc, bornProb ]

/-! ## Arbitrariness: any distribution is realized by the Born rule -/

/-- Any conditional probability `p ∈ [0,1]` is `cos²(θ)` for some angle `θ`
(the book: "these conditional probabilities are arbitrary"). -/
theorem cos_sq_surjective {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1) :
    ∃ t : ℝ, Real.cos t ^ 2 = p := by
  refine ⟨Real.arccos (Real.sqrt p), ?_⟩
  rw [Real.cos_arccos] <;> nlinarith [Real.sq_sqrt hp0, Real.sqrt_nonneg p]

/-
**Headline (Euler's formula for a generic phase-space).** Every probability
distribution `p` on `n` states is realized by the Born rule of some
wave-function, i.e. there exist Euler angles `θ` whose stick-breaking Born
distribution `bornProb θ n` equals `p`.
-/
set_option maxHeartbeats 1000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
theorem exists_angles_realize (n : ℕ) (p : Fin n → ℝ)
    (hp : ∀ i, 0 ≤ p i) (hsum : ∑ i, p i = 1) :
    ∃ θ : ℕ → ℝ, ∀ i : Fin n, bornProb θ n i = p i := by
  rcases n with ( _ | n );
  · aesop;
  · -- Set the remaining mass `R j = 1 - ∑ k ∈ Finset.range j, q k`.
    set q : ℕ → ℝ := fun k => if h : k < n + 1 then p ⟨k, h⟩ else 0
    set R : ℕ → ℝ := fun j => 1 - ∑ k ∈ Finset.range j, q k;
    -- Set the target conditional `t j = if R j = 0 then 0 else q j / R j`, and the angle `θ j =
    -- Real.arccos (Real.sqrt (t j))`.
    obtain ⟨θ, hθ⟩ : ∃ θ : ℕ → ℝ, ∀ j, Real.cos (θ j) ^ 2 = if R j = 0 then 0 else q j / R j := by
      have h_t_range : ∀ j,        0 ≤ (if R j = 0 then 0 else q j / R j) ∧ (if R j = 0 then 0 else
          q j / R j) ≤ 1 := by
        intro j
        have hR_nonneg : 0 ≤ R j := by
          refine sub_nonneg_of_le ?_;
          by_cases hj : j ≤ n + 1;
          · rw [ ← hsum ];
            refine le_trans ( Finset.sum_le_sum (g := ?_) fun i hi => ?_ ) ?_;
            focus (use fun i => if h : i < n + 1 then p ⟨ i, h ⟩ else 0);
            · aesop;
            · refine le_trans ( Finset.sum_le_sum_of_subset_of_nonneg ( Finset.range_mono hj ) fun _
                _ _ => ?_ ) ?_;
              · grind;
              · simp [ Finset.sum_range, Fin.sum_univ_castSucc ];
          · rw [ ← Finset.sum_range_add_sum_Ico _ ( by linarith : n + 1 ≤ j ) ];
            simp? +zetaDelta at *;
            simp_all only [Fin.sum_univ_castSucc, sum_range, Fin.eta, dite_eq_ite, Fin.val_castSucc,
                Fin.is_le', ↓reduceIte, Fin.val_last, le_refl, add_le_iff_nonpos_right];
            exact Finset.sum_nonpos fun x hx => by split_ifs <;> linarith [ Finset.mem_Ico.mp hx ] ;
        have hq_le_R : q j ≤ R j := by
          have hq_le_R : ∑ k ∈ Finset.range (j + 1), q k ≤ 1 := by
            have hq_le_R : ∑ k ∈ Finset.range (j + 1), q k ≤ ∑ k ∈ Finset.range (n + 1), q k := by
              by_cases hj : j < n + 1;
              · exact Finset.sum_le_sum_of_subset_of_nonneg ( Finset.range_mono (
                  by linarith ) ) fun _ _ _ => by aesop;
              · rw [ Finset.sum_subset ( Finset.range_mono ( by linarith : n + 1 ≤ j + 1 ) ) fun x
                                                                hx₁ hx₂ => by aesop ];
            exact hq_le_R.trans ( by rw [ ← hsum ] ; rw [ Finset.sum_range ] ; exact
                                     Finset.sum_le_sum fun i _ => by aesop );
          simp_all [ Finset.sum_range_succ ];
          linarith
        have ht_range : 0 ≤ (if R j = 0 then 0 else q j / R j) ∧ (if R j = 0 then 0 else q j / R j)
            ≤ 1 := by
          split_ifs <;> norm_num [ * ];
          exact ⟨ div_nonneg ( by aesop ) hR_nonneg, div_le_one_of_le₀ hq_le_R hR_nonneg ⟩
        exact ht_range;
      exact ⟨ fun j => Real.arccos ( Real.sqrt ( if R j = 0 then 0 else q j / R j ) ), fun j =>
          by rw [ Real.cos_arccos ] <;> nlinarith [ h_t_range j, Real.mul_self_sqrt ( h_t_range j
              |>.1 ) ] ⟩;
    -- Main claim: `remainder θ j = R j` for all j, by induction.
    have h_remainder : ∀ j, remainder θ j = R j := by
      intro j;
      induction j with
      | zero => ?_
      | succ j ih => ?_
      · unfold remainder R; norm_num;
      · have h_remainder_succ : remainder θ (j + 1) = remainder θ j * (1 - if R j = 0 then 0 else q
          j / R j) := by
          rw [ ← hθ j, remainder_succ ];
          rw [ Real.sin_sq ];
        by_cases hj : R j = 0 <;> simp_all only [↓reduceIte, sub_zero, mul_one] ;
        · simp? +zetaDelta at *;
          by_cases hj' : j ≤ n <;> simp_all [ Finset.sum_range_succ ];
          · have h_sum_le_one : ∑ k ∈ Finset.range (j + 1),            (if h : k ≤ n then p ⟨k,
              by linarith⟩ else 0) ≤ 1 := by
              rw [ ← hsum ];
              rw [ Finset.sum_fin_eq_sum_range ];
              rw [ ← Finset.sum_range_add_sum_Ico _ ( by linarith : j + 1 ≤ n + 1 ) ];
              exact le_add_of_le_of_nonneg ( Finset.sum_le_sum fun _ _ =>
                  by split_ifs <;> linarith ) ( Finset.sum_nonneg fun _ _ =>
                      by split_ifs <;> linarith [ hp ⟨ _, by linarith [ Finset.mem_Ico.mp ‹_› ] ⟩ ]
                                                             );
            simp_all [ Finset.sum_range_succ ];
            linarith [ hp ⟨ j, by linarith ⟩ ];
          · grind;
        · simp? +zetaDelta at *;
          rw [ Finset.sum_range_succ, mul_sub, mul_one, mul_div_cancel₀ _ hj ] ; ring;
    use θ; intro i; simp only [bornProb, Order.lt_add_one_iff, Order.add_one_le_iff, h_remainder] ;
    split_ifs <;> simp_all only [Fin.sum_univ_castSucc, not_lt];
    · rw [ stick_eq, h_remainder, hθ ];
      split_ifs <;> simp_all [ mul_div_cancel₀ ];
      · have h_contra : ∑ k ∈ Finset.range (i + 1), q k ≤ ∑ k ∈ Finset.range (n + 1), q k := by
          exact Finset.sum_le_sum_of_subset_of_nonneg ( Finset.range_mono (
              by linarith ) ) fun _ _ _ => by aesop;
        simp +zetaDelta at *;
        simp_all [ Finset.sum_range, Fin.sum_univ_castSucc ];
        grind;
      · grind;
    · simp? +zetaDelta at *;
      simp_all only [Fin.val_last, lt_self_iff_false, not_false_eq_true, not_lt,
          Fin.eq_last_of_not_lt];
      simp_all only [sum_range, Fin.is_le', ↓reduceDIte];
      linarith!

end BookProof.ChapterE2
