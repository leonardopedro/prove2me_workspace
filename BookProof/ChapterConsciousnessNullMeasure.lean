import Mathlib

/-!
# Chapter "Consciousness as a representation of a Bayesian prior",
§"Non-informative priors vs. Fermi Paradox and Artificial General Intelligence"
— null-measure sets need not be "small".

Source: `book.tex`, chapter *"Consciousness as a representation of a Bayesian
prior"* (line ~9122).

The book argues, in the course of solving the Fermi paradox (a "null-measure"
event is not automatically special or impossible):

> *"A point with null measure is not necessarily special, if all other points
> also have null-measure as in the uniform measure in a real interval.
> Moreover, a subset with null measure does not imply that the subset has one
> less dimension than the set, since there are subsets of a real interval which
> have a fractal dimension (which can be very close to one, but not one) and
> thus are also uncountable. Thus, life could only exist on Earth and still be
> abundant somehow."*

This module formalizes the self-contained *measure-theoretic* core of that
remark. Three phenomena are recorded, culminating in the headline
`exists_uncountable_null_subset`:

* **No point is special.** Under the (uniform) Lebesgue measure on `ℝ` every
  singleton is null, and all singletons carry the *same* measure `0`
  (`singleton_volume_zero`, `singletons_equal_measure`). So a single point's
  null measure does not distinguish it from any other point.

* **Null does not imply "one fewer dimension"/countable.** A *countable* set is
  null (`countable_volume_zero`, e.g. the rationals `rat_range_volume_zero`),
  but the converse fails badly: the ternary **Cantor set** is *uncountable*
  (`cantorSet_uncountable`) yet has Lebesgue measure zero
  (`cantorSet_volume_zero`). It is the book's example of a null subset of a real
  interval that is nonetheless "big" (uncountable, positive fractal dimension).

* **Headline.** There is an uncountable subset of the unit interval with
  measure zero (`exists_uncountable_null_subset`), witnessed by the Cantor set.

The measure-zero proof uses the self-similarity of the Cantor set,
`cantorSet = (·/3) '' cantorSet ∪ ((2 + ·)/3) '' cantorSet`
(`cantorSet_eq_union_halves`), together with the scaling/translation behaviour
of Lebesgue measure to obtain `μ(C) ≤ (2/3)·μ(C)` with `μ(C) < ∞`, forcing
`μ(C) = 0`. Uncountability uses Mathlib's homeomorphism
`cantorSetEquivNatToBool : cantorSet ≃ (ℕ → Bool)` and Cantor's theorem
`ℵ₀ < 2 ^ ℵ₀`.
-/

namespace BookProof.ConsciousnessNullMeasure

open MeasureTheory Set

/-! ## No point is special: singletons are null and all have the same measure -/

/-- Under the (uniform) Lebesgue measure on `ℝ`, every single point has null
measure: no individual point is "special". -/
theorem singleton_volume_zero (x : ℝ) : volume ({x} : Set ℝ) = 0 := by simp

/-- All singletons carry the *same* Lebesgue measure (namely `0`); the null
measure of a point does not distinguish it from any other point. -/
theorem singletons_equal_measure (x y : ℝ) :
    volume ({x} : Set ℝ) = volume ({y} : Set ℝ) := by simp

/-! ## Countable sets are null (but null does not imply countable) -/

/-- Any countable subset of `ℝ` is Lebesgue-null. -/
theorem countable_volume_zero {s : Set ℝ} (h : s.Countable) : volume s = 0 :=
  h.measure_zero _

/-- The rationals, embedded in `ℝ`, form a null set: "the rationals are not
enough" to fill up positive measure. -/
theorem rat_range_volume_zero : volume (Set.range ((↑) : ℚ → ℝ)) = 0 :=
  (Set.countable_range _).measure_zero _

/-! ## The Cantor set: an uncountable null subset of the interval -/

/-- The Cantor space `ℕ → Bool` is uncountable (Cantor's theorem: `ℵ₀ < 2^ℵ₀`). -/
private theorem natBool_uncountable : Uncountable (ℕ → Bool) := by
  rw [← not_countable_iff, ← Cardinal.mk_le_aleph0_iff]
  push_neg
  rw [Cardinal.mk_arrow]
  simp only [Cardinal.mk_bool, Cardinal.mk_nat, Cardinal.lift_ofNat, Cardinal.lift_aleph0]
  have := Cardinal.cantor Cardinal.aleph0
  simpa using this

/-- The ternary Cantor set is **uncountable** — a null set of positive fractal
dimension, not "one dimension less" than the interval. -/
theorem cantorSet_uncountable : ¬ cantorSet.Countable := by
  rw [← Set.countable_coe_iff, not_countable_iff]
  exact (Equiv.uncountable_iff cantorSetEquivNatToBool).mpr natBool_uncountable

/-- The lower self-similar copy `(·/3) '' C` has measure `(1/3)·μ(C)`. -/
private theorem half1 :
    volume ((fun x => x / 3) '' cantorSet) = ENNReal.ofReal (3⁻¹) * volume cantorSet := by
  have himg : (fun x => x / 3) '' cantorSet = (fun y => y * 3) ⁻¹' cantorSet := by
    ext y
    simp only [Set.mem_image, Set.mem_preimage]
    constructor
    · rintro ⟨x, hx, rfl⟩
      rw [div_mul_cancel₀]
      · exact hx
      · norm_num
    · intro h; exact ⟨y * 3, h, by ring⟩
  rw [himg]
  have h := Real.volume_preimage_mul_right (a := 3) (by norm_num) cantorSet
  rw [abs_of_pos (by norm_num : (3⁻¹ : ℝ) > 0)] at h
  exact h

/-- The upper self-similar copy `((2 + ·)/3) '' C` has measure `(1/3)·μ(C)`. -/
private theorem half2 :
    volume ((fun x => (2 + x) / 3) '' cantorSet)
      = ENNReal.ofReal (3⁻¹) * volume cantorSet := by
  have himg : (fun x => (2 + x) / 3) '' cantorSet = (fun y => 3 * y - 2) ⁻¹' cantorSet := by
    ext y
    simp only [Set.mem_image, Set.mem_preimage]
    constructor
    · rintro ⟨x, hx, rfl⟩
      have : 3 * ((2 + x) / 3) - 2 = x := by ring
      rw [this]; exact hx
    · intro h; exact ⟨3 * y - 2, h, by ring⟩
  rw [himg]
  have hcomp : (fun y : ℝ => 3 * y - 2) ⁻¹' cantorSet
      = (fun z => z + (-(2 / 3))) ⁻¹' ((fun y => 3 * y) ⁻¹' cantorSet) := by
    ext y; simp only [Set.mem_preimage]; ring_nf
  rw [hcomp, measure_preimage_add_right]
  rw [show (fun y : ℝ => 3 * y) = (3 * ·) from rfl, Real.volume_preimage_mul_left (by norm_num)]
  simp

/-- The Cantor set has finite measure (it lies inside `[0,1]`). -/
private theorem cantor_finite : volume cantorSet < ⊤ := by
  have h : volume cantorSet ≤ volume (Set.Icc (0 : ℝ) 1) :=
    measure_mono cantorSet_subset_unitInterval
  refine lt_of_le_of_lt h ?_
  rw [Real.volume_Icc]; simp

/-- The ternary Cantor set has Lebesgue **measure zero**: an uncountable set can
still be null. -/
theorem cantorSet_volume_zero : volume cantorSet = 0 := by
  have hle : volume cantorSet ≤ ENNReal.ofReal (2 / 3) * volume cantorSet := by
    calc volume cantorSet
        = volume ((fun x => x / 3) '' cantorSet ∪ (fun x => (2 + x) / 3) '' cantorSet) := by
          rw [← cantorSet_eq_union_halves]
      _ ≤ volume ((fun x => x / 3) '' cantorSet)
            + volume ((fun x => (2 + x) / 3) '' cantorSet) := measure_union_le _ _
      _ = ENNReal.ofReal (3⁻¹) * volume cantorSet
            + ENNReal.ofReal (3⁻¹) * volume cantorSet := by rw [half1, half2]
      _ = ENNReal.ofReal (2 / 3) * volume cantorSet := by
          rw [← add_mul, ← ENNReal.ofReal_add (by norm_num) (by norm_num)]; norm_num
  by_contra hne
  conv_lhs at hle => rw [← one_mul (volume cantorSet)]
  rw [ENNReal.mul_le_mul_iff_left hne cantor_finite.ne] at hle
  rw [ENNReal.one_le_ofReal] at hle
  norm_num at hle

/-! ## Headline: an uncountable null subset of the unit interval -/

/-- **Headline.** There is an uncountable subset of the unit interval `[0,1]`
with Lebesgue measure zero — the book's point that a null-measure subset of a
real interval need not be "one dimension less", and can in fact be uncountable.
Witnessed by the ternary Cantor set. -/
theorem exists_uncountable_null_subset :
    ∃ S : Set ℝ, S ⊆ Set.Icc 0 1 ∧ ¬ S.Countable ∧ volume S = 0 :=
  ⟨cantorSet, cantorSet_subset_unitInterval, cantorSet_uncountable, cantorSet_volume_zero⟩

end BookProof.ConsciousnessNullMeasure
