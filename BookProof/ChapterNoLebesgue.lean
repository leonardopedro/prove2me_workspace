import Mathlib

/-!
# Chapter (Yang–Mills / Statistical Field Theory) — No infinite-dimensional Lebesgue measure

This file formalizes a foundational claim that `book.tex` invokes repeatedly to
justify the whole *free-field / gauge-variant probability measure* framework
(Chapter *"Quantization due to time-evolution: Yang-Mills and Classical
Statistical Field Theory"*, `book.tex` line ~6660, and again in the gauge
chapters, e.g. line 2128):

> "the Feynman's path integral assumes the existence of a translation-invariant
> `σ`-finite (i.e. Lebesgue like) measure … Yet, it is proved that in rigor such
> infinite-dimensional Lebesgue measure cannot exist."

The precise mathematical statement is the classical fact that **an
infinite-dimensional normed space carries no non-trivial translation-invariant
Borel measure that is finite on bounded sets** (there is no
"infinite-dimensional Lebesgue measure"). This is the rigorous content behind
the book's assertion that a gauge-*invariant* vacuum measure is impossible while
a gauge-*variant* (e.g. Gaussian) one is fine.

## Proof

The engine is Mathlib's `exists_seq_norm_le_one_le_norm_sub`: in an
infinite-dimensional normed space over a complete field there is a bounded
sequence that is `1`-separated. Rescaling it by `2r` produces, for every radius
`r > 0`, infinitely many **pairwise disjoint** open balls of radius `r`, all
contained in one bounded set. If the measure of a ball of radius `r` were
positive, translation invariance would force this bounded set to have infinite
measure — contradicting finiteness on bounded sets. Hence every ball has measure
`0`, and since the whole space is a countable union of balls, the measure is
`0`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open MeasureTheory Metric
open scoped ENNReal

namespace BookProof.ChapterNoLebesgue

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [MeasurableSpace E] [BorelSpace E]

omit [NormedSpace ℝ E] in
/-- Translation invariance for balls: a translation-invariant measure gives every
ball the same measure as the corresponding ball centered at the origin.
-/
theorem measure_ball_eq_measure_ball_zero (μ : Measure E) [μ.IsAddLeftInvariant]
    (a : E) (r : ℝ) : μ (Metric.ball a r) = μ (Metric.ball 0 r) := by
  convert MeasureTheory.measure_preimage_add μ ( -a ) ( Metric.ball 0 r ) using 1;
  simp [ sub_eq_add_neg ]

/-- **Core estimate.** For a translation-invariant measure that is finite on
bounded sets on an infinite-dimensional normed space, every ball centered at the
origin has measure zero.

The proof rescales a bounded `1`-separated sequence by `2r`, obtaining infinitely
many pairwise-disjoint radius-`r` balls inside a single bounded set; positivity
of `μ (ball 0 r)` would make that bounded set have infinite measure.
-/
theorem measure_ball_zero_eq_zero (hE : ¬ FiniteDimensional ℝ E)
    (μ : Measure E) [μ.IsAddLeftInvariant]
    (hbdd : ∀ s : Set E, Bornology.IsBounded s → μ s ≠ ∞)
    {r : ℝ} (hr : 0 < r) : μ (Metric.ball 0 r) = 0 := by
  -- By contradiction, assume `c := μ (ball 0 r) ≠ 0` (i.e. `0 < c`).
  by_contra hc
  have hc_pos : 0 < μ (Metric.ball 0 r) := by
    exact pos_iff_ne_zero.mpr hc;
  -- By `exists_seq_norm_le_one_le_norm_sub hE`, obtain a bounded `1`-separated sequence `f : ℕ →
  -- E`.
  obtain ⟨R, f, hR⟩ : ∃ R : ℝ,    ∃ f : ℕ → E, 1 < R ∧ (∀ n, ‖f n‖ ≤ R) ∧ Pairwise (fun m n => 1 ≤
      ‖f m - f n‖) := by
    convert exists_seq_norm_le_one_le_norm_sub hE using 1;
  -- Consider the balls `A n := Metric.ball ((2*r) • f n) r`.
  set A : ℕ → Set E := fun n => Metric.ball ((2 * r) • f n) r;
  have hA_disjoint : Pairwise (fun m n => Disjoint (A m) (A n)) := by
    intro m n hmn; simp_all only [ne_eq]  ;
    refine Metric.ball_disjoint_ball ?_;
    rw [ dist_eq_norm, ← smul_sub, norm_smul, Real.norm_of_nonneg (
        by positivity ) ] ;      nlinarith [ hR.2.2 hmn ] ;;
  have hA_subset : ⋃ n, A n ⊆ Metric.ball 0 (2 * r * R + r) := by
    simp only [Set.subset_def, Set.mem_iUnion, mem_ball, dist_zero_right, forall_exists_index, A];
    intro x n hx;      rw [ dist_eq_norm ] at hx;      rw [ ← sub_add_cancel x ( ( 2 * r ) • f n ) ]
        ;      exact lt_of_le_of_lt ( norm_add_le _ _ ) ( by nlinarith [ norm_smul_of_nonneg ( show
                                                             0 ≤ 2 * r
                                                                 by positivity ) ( f n ), hR.2.1 n ]
                                                                     ) ;;
  have hA_measure : μ (⋃ n, A n) ≠ ∞ := by
    exact ne_of_lt ( lt_of_le_of_lt ( MeasureTheory.measure_mono hA_subset ) ( lt_top_iff_ne_top.mpr
        ( hbdd _ ( Metric.isBounded_ball ) ) ) );
  have hA_sum_measure : μ (⋃ n, A n) = ∑' n, μ (A n) := by
    rw [ MeasureTheory.measure_iUnion hA_disjoint ];
    exact fun n => measurableSet_ball;
  have hA_sum_measure_pos : ∑' n, μ (A n) = ∑' n : ℕ, μ (Metric.ball 0 r) := by
    exact tsum_congr fun n => measure_ball_eq_measure_ball_zero μ _ _;
  have hA_sum_measure_inf : ∑' n : ℕ, μ (Metric.ball 0 r) = ⊤ := by
    simp [ hc, ENNReal.tsum_const ];
  aesop;

/-- **No infinite-dimensional Lebesgue measure.** On an infinite-dimensional real
normed space, the only translation-invariant Borel measure that is finite on
bounded sets is the zero measure. This is the rigorous statement behind
`book.tex`'s claim that "such infinite-dimensional Lebesgue measure cannot
exist".
-/
theorem eq_zero_of_isAddLeftInvariant_of_finite_on_bounded
    (hE : ¬ FiniteDimensional ℝ E)
    (μ : Measure E) [μ.IsAddLeftInvariant]
    (hbdd : ∀ s : Set E, Bornology.IsBounded s → μ s ≠ ∞) : μ = 0 := by
  -- By `MeasureTheory.Measure.measure_univ_eq_zero` it suffices to show `μ Set.univ = 0`.
  suffices h_univ_zero : μ Set.univ = 0 by
    aesop
  generalize_proofs at *; (
  -- Note `Set.univ = ⋃ (n : ℕ), Metric.ball 0 (n + 1)`.
  have h_univ_eq_iUnion : Set.univ = ⋃ n : ℕ, Metric.ball (0 : E) (n + 1) := by
    ext x
    simp ;
  rw [ h_univ_eq_iUnion, MeasureTheory.measure_iUnion_null_iff ];
  exact fun n => measure_ball_zero_eq_zero hE μ hbdd ( by positivity ))

/-- Restated existence form: there is **no** non-zero translation-invariant Borel
measure that is finite on bounded sets on an infinite-dimensional normed space. -/
theorem not_exists_nonzero_isAddLeftInvariant_finite_on_bounded
    (hE : ¬ FiniteDimensional ℝ E) :
    ¬ ∃ μ : Measure E, μ.IsAddLeftInvariant ∧
      (∀ s : Set E, Bornology.IsBounded s → μ s ≠ ∞) ∧ μ ≠ 0 := by
  rintro ⟨μ, hinv, hbdd, hne⟩
  exact hne (eq_zero_of_isAddLeftInvariant_of_finite_on_bounded hE μ hbdd)

/-- Contrapositive phrasing used in the book: a translation-invariant measure that
is *positive* on some nonempty open ball (a "Lebesgue-like" normalization) cannot
be finite on all bounded sets. -/
theorem not_finite_on_bounded_of_isAddLeftInvariant_of_pos_ball
    (hE : ¬ FiniteDimensional ℝ E)
    (μ : Measure E) [μ.IsAddLeftInvariant]
    {a : E} {r : ℝ} (hr : 0 < r) (hpos : 0 < μ (Metric.ball a r)) :
    ¬ ∀ s : Set E, Bornology.IsBounded s → μ s ≠ ∞ := by
  intro hbdd
  have h0 : μ (Metric.ball a r) = 0 := by
    rw [measure_ball_eq_measure_ball_zero μ a r]
    exact measure_ball_zero_eq_zero hE μ hbdd hr
  rw [h0] at hpos
  exact lt_irrefl 0 hpos

end BookProof.ChapterNoLebesgue
