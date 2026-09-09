import Mathlib

/-!
# Chapter F6 — Quantum Flow Matching: the Misra–Gries heavy-hitter bound (roadmap N14, F3.5, §8
Phase 4)

This file formalizes the **Misra–Gries** frequency-estimation guarantee used in
the QFM tomographic-recovery pipeline (source `RiemannProof/QFM.tex` §8 Phase 4;
reference implementation `../unfer/qfm/`).  With a table of at most `k` counters,
the Misra–Gries summary of a stream `s` produces, for every item `x`, a frequency
estimate `f̂(x) = (mg k s) x` satisfying

  `f(x) − N/k ≤ f̂(x) ≤ f(x)`,

where `f(x) = s.count x` is the true frequency and `N = s.length` the stream
length.  This is the top-1 peak-recovery guarantee: the estimate never
overshoots and undershoots by at most `N/k`.

## Model

The counter table is a finitely-supported map `T : α →₀ ℕ`.  Processing one item
`x` with capacity `k`:

* if `x` is already counted (`0 < T x`) or there is a free slot
  (`T.support.card < k`), increment `x`'s counter (`T + single x 1`);
* otherwise (`x` absent and the table full) **decrement every counter by one**
  (`T.mapRange (· - 1)`), which drops any counter that hits `0`.

`mgD k T s` counts the number of decrement rounds along the run.

## Deliverables

* `mg_upper` — the estimate never overshoots: `(mg k s) x ≤ s.count x`.
* `mg_lower` — the estimate undershoots by at most the decrement count:
  `s.count x ≤ (mg k s) x + mgD k 0 s`.
* `mgD_bound` — the decrement count is small: `k * mgD k 0 s ≤ s.length`.
* `misra_gries_bound` — the headline `f(x) − N/k ≤ f̂(x) ≤ f(x)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open scoped BigOperators

namespace BookProof.ChapterF6

variable {α : Type*} [DecidableEq α]

/-- One Misra–Gries step with capacity `k`: increment if the item is present or
there is a free slot, else decrement every counter by one. -/
noncomputable def mgStep (k : ℕ) (T : α →₀ ℕ) (x : α) : α →₀ ℕ :=
  if 0 < T x ∨ T.support.card < k then
    T + Finsupp.single x 1
  else
    T.mapRange (fun n => n - 1) (by norm_num)

/-- The Misra–Gries table obtained by folding `mgStep` over the stream from an
initial table `T`. -/
noncomputable def mgT (k : ℕ) (T : α →₀ ℕ) (s : List α) : α →₀ ℕ :=
  s.foldl (mgStep k) T

/-- The number of decrement rounds along a Misra–Gries run. -/
noncomputable def mgD (k : ℕ) : (α →₀ ℕ) → List α → ℕ
  | _, [] => 0
  | T, x :: xs => (if 0 < T x ∨ T.support.card < k then 0 else 1) + mgD k (mgStep k T x) xs

/-- The Misra–Gries summary of a stream `s` with capacity `k` (empty initial
table). -/
noncomputable def mg (k : ℕ) (s : List α) : α →₀ ℕ := mgT k 0 s

/-- The total mass stored in a table. -/
noncomputable def mgSum (T : α →₀ ℕ) : ℕ := T.sum (fun _ n => n)

omit [DecidableEq α] in
@[simp] theorem mgT_nil (k : ℕ) (T : α →₀ ℕ) : mgT k T [] = T := rfl

omit [DecidableEq α] in
theorem mgT_cons (k : ℕ) (T : α →₀ ℕ) (x : α) (xs : List α) :
    mgT k T (x :: xs) = mgT k (mgStep k T x) xs := by
  simp [mgT, List.foldl_cons]

omit [DecidableEq α] in
@[simp] theorem mgD_nil (k : ℕ) (T : α →₀ ℕ) : mgD k T [] = 0 := rfl

omit [DecidableEq α] in
theorem mgD_cons (k : ℕ) (T : α →₀ ℕ) (x : α) (xs : List α) :
    mgD k T (x :: xs) =
      (if 0 < T x ∨ T.support.card < k then 0 else 1) + mgD k (mgStep k T x) xs := rfl

/-! ### Per-step facts -/

omit [DecidableEq α] in
/-
One step never grows the support beyond capacity `k`.
-/
theorem mgStep_card_le (k : ℕ) (T : α →₀ ℕ) (x : α) (hT : T.support.card ≤ k) :
    (mgStep k T x).support.card ≤ k := by
  classical
  refine le_trans ( Finset.card_le_card (t := ?_) ?_ ) ?_;
  focus (exact if 0 < T x ∨ T.support.card < k then insert x T.support else T.support);
  · intro y hy; split_ifs <;> simp_all only [mgStep, ↓reduceIte, Finsupp.mem_support_iff,
      Finsupp.coe_add, Pi.add_apply, ne_eq, Nat.add_eq_zero_iff, not_and, Finset.mem_insert,
          Finsupp.mapRange_apply, not_or, not_lt, nonpos_iff_eq_zero] ;
    · contrapose! hy; aesop;
    · exact fun h => hy <| by simp [ h ] ;
  · grind

/-
One step increments the counter of `x` by at most one and never changes any
other counter by more than the indicator of `x`.
-/
theorem mgStep_apply_le (k : ℕ) (T : α →₀ ℕ) (x y : α) :
    (mgStep k T x) y ≤ T y + (if y = x then 1 else 0) := by
  unfold mgStep;
  split_ifs <;> simp_all [ Finsupp.mapRange_apply ]

/-
Per-step lower bound: the counter of `y` plus the occurrence indicator is at
most the new counter plus the decrement indicator.
-/
theorem mgStep_le_apply_add (k : ℕ) (T : α →₀ ℕ) (x y : α) :
    T y + (if y = x then 1 else 0)
      ≤ (mgStep k T x) y + (if 0 < T x ∨ T.support.card < k then 0 else 1) := by
  unfold mgStep; split_ifs <;> simp_all [ Finsupp.mapRange_apply ] ;
  omega

/-! ### The capacity invariant -/

omit [DecidableEq α] in
/-
The running table never exceeds capacity `k`.
-/
theorem mgT_card_le (k : ℕ) (T : α →₀ ℕ) (s : List α) (hT : T.support.card ≤ k) :
    (mgT k T s).support.card ≤ k := by
  induction s generalizing T with
  | nil => ?_
  | cons x s ih => ?_
  all_goals simp_all only [mgT_nil, mgT_cons]
  exact ih _ ( mgStep_card_le k T x hT )

/-! ### Upper bound -/

/-
Upper bound (general initial table): the estimate is at most the initial
value plus the number of occurrences.
-/
theorem mgT_apply_le (k : ℕ) (T : α →₀ ℕ) (s : List α) (y : α) :
    (mgT k T s) y ≤ T y + s.count y := by
  induction s using List.reverseRecOn generalizing T y with
  | nil => ?_
  | append_singleton s x ih => ?_
  · simp [ mgT ];
  · simp_all only [mgT, List.count, List.foldl_append, List.foldl_cons, List.foldl_nil,
      List.countP_append, List.countP_singleton, beq_iff_eq];
    refine le_trans ( mgStep_apply_le k _ _ _ ) ?_;
    grind

/-- **Upper bound**: the Misra–Gries estimate never overshoots the true
frequency. -/
theorem mg_upper (k : ℕ) (s : List α) (y : α) : (mg k s) y ≤ s.count y := by
  have := mgT_apply_le k 0 s y
  simpa [mg] using this

/-! ### Lower bound -/

/-
Lower bound (general initial table): the true count plus initial value is at
most the estimate plus the number of decrement rounds.
-/
theorem mgT_le_apply_add_mgD (k : ℕ) (T : α →₀ ℕ) (s : List α) (y : α) :
    T y + s.count y ≤ (mgT k T s) y + mgD k T s := by
  induction s using List.reverseRecOn generalizing T y with
  | nil => ?_
  | append_singleton s x ih => ?_
  · simp [ mgT, mgD ];
  · have h_step : mgD k T (s ++ [x]) = mgD k T s + (if 0 < (mgT k T s) x ∨ (mgT k T s).support.card
      < k then 0 else 1) := by
      have h_step : ∀ (T : α →₀ ℕ) (s : List α) (x : α),        mgD k T (s ++ [x]) = mgD k T s + (if
          0 < (mgT k T s) x ∨ (mgT k T s).support.card < k then 0 else 1) := by
        intros T s x
        induction s generalizing T with
        | nil => ?_
        | cons s x ih => ?_
        · simp [ mgD, mgT ];
        · simp [ mgD, mgT, ih ];
          ring;
      exact h_step T s x;
    have := mgStep_le_apply_add k ( mgT k T s ) x y; simp_all [ mgT ] ;
    grind

/-- **Lower bound**: the estimate undershoots by at most the number of decrement
rounds. -/
theorem mg_lower (k : ℕ) (s : List α) (y : α) :
    s.count y ≤ (mg k s) y + mgD k 0 s := by
  have := mgT_le_apply_add_mgD k 0 s y
  simpa [mg] using this

/-! ### The decrement count is small -/

omit [DecidableEq α] in
/-
The support size lower-bounds the stored mass (every stored counter is `≥ 1`).
-/
theorem mgSum_ge_card (T : α →₀ ℕ) : T.support.card ≤ mgSum T := by
  exact Finset.card_eq_sum_ones _ ▸ Finset.sum_le_sum fun x hx => Nat.one_le_iff_ne_zero.mpr (
      Finsupp.mem_support_iff.mp hx )

omit [DecidableEq α] in
/-
An increment adds exactly one unit of mass.
-/
theorem mgSum_add_single (T : α →₀ ℕ) (x : α) :
    mgSum (T + Finsupp.single x 1) = mgSum T + 1 := by
  simp [ mgSum, Finsupp.sum_add_index' ]

omit [DecidableEq α] in
/-
A decrement round removes exactly `T.support.card` units of mass.
-/
theorem mgSum_mapRange_pred (T : α →₀ ℕ) :
    mgSum (T.mapRange (fun n => n - 1) (by norm_num)) = mgSum T - T.support.card := by
  refine eq_tsub_of_add_eq ?_;
  unfold mgSum; simp only [implies_true, Finsupp.sum_mapRange_index] ;
  zify [ Finset.sum_add_distrib ];
  rw [ Finset.card_eq_sum_ones ] ;    rw [ Finsupp.sum, Finsupp.sum ] ; simp only [Finset.sum_const,
      smul_eq_mul, mul_one]  ; ring;
  rw [ Finset.sum_congr rfl fun x hx => Nat.cast_sub <| Nat.one_le_iff_ne_zero.mpr <|
      Finsupp.mem_support_iff.mp hx ] ; simp 

omit [DecidableEq α] in
/-
The core mass-conservation invariant: each decrement round removes exactly
`k` units of mass (the table is full), so `mgSum + (k+1)·D` is conserved.
-/
theorem mgT_sum_add (k : ℕ) (T : α →₀ ℕ) (s : List α) (hT : T.support.card ≤ k) :
    mgSum (mgT k T s) + (k + 1) * mgD k T s = mgSum T + s.length := by
  induction s generalizing T with
  | nil => ?_
  | cons x s ih => ?_
  · simp [ mgT, mgD ];
  · simp_all only [mgT, List.foldl_cons, mgD, List.length_cons];
    convert congr_arg ( · + ( k + 1 ) * ( if 0 < T x ∨ T.support.card < k then 0 else 1 ) ) ( ih (
                          mgStep k T x ) ( mgStep_card_le k T x hT ) ) using 1 ;
    focus (ring);
    split_ifs <;> simp_all only [mgStep, ↓reduceIte, mul_zero, add_zero, not_or, not_lt,
        nonpos_iff_eq_zero, lt_self_iff_false, false_or, mul_one];
    · rw [ mgSum_add_single ] ; ring;
    · rw [ if_neg ( by linarith ) ];
      rw [ mgSum_mapRange_pred ] ; ring;
      linarith [ Nat.sub_add_cancel ( show T.support.card ≤ mgSum T from mgSum_ge_card T ) ]

omit [DecidableEq α] in
/-
**Decrement bound**: at most `N/k` decrement rounds occur.
-/
theorem mgD_bound (k : ℕ) (s : List α) : k * mgD k 0 s ≤ s.length := by
  have h_dec : (k + 1) * mgD k 0 s ≤ s.length := by
    have := mgT_sum_add k 0 s; simp_all only [Finsupp.support_zero, Finset.card_empty, zero_le,
        mgSum, Finsupp.sum_zero_index, zero_add, forall_const, ge_iff_le] ;
    exact this ▸ Nat.le_add_left _ _;
  grind

/-! ### The headline bound -/

/-
**Misra–Gries heavy-hitter bound** (F3.5): with capacity `k ≥ 1`, the
frequency estimate satisfies `f(x) − N/k ≤ f̂(x) ≤ f(x)`, where `f(x) = s.count x`
and `N = s.length`.
-/
theorem misra_gries_bound (k : ℕ) (hk : 1 ≤ k) (s : List α) (x : α) :
    s.count x - s.length / k ≤ (mg k s) x ∧ (mg k s) x ≤ s.count x := by
  refine ⟨ Nat.sub_le_of_le_add ?_, ?_ ⟩
  · convert mg_lower k s x |> le_trans <| Nat.add_le_add_left _ _ using 1;
    exact Nat.le_div_iff_mul_le hk |>.2 ( by linarith [ mgD_bound k s ] );
  · exact mg_upper k s x

end BookProof.ChapterF6
