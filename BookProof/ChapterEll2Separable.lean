import Mathlib
import BookProof.ChapterRieszFischer

/-!
# The PA-free completion is separable: a *countable* dense definable fragment

`BookProof/ChapterRieszFischer.lean` shows that the finitely-supported core
`ℕ →₀ ℝ` is dense in `ℓ²(ℕ)` and strictly smaller than it.  That core is,
however, still uncountable, whereas the manuscript's definability argument (see
`BookProof/ChapterDefinabilityFragment.lean` and
`BookProof/ChapterCountableDefinability.lean`) needs a *countable* fragment: only
countably many vectors can be named by terms of a countable language.

This file closes that gap.  The finitely-supported **rational** vectors form a
countable set which is still dense in `ℓ²(ℕ)`; consequently `ℓ²(ℕ)` is a
separable metric space, and the whole completion is the closure of a countable
set of nameable vectors.

## Deliverables

* `ratVec` — the finitely-supported rational vectors, indexed by `ℕ →₀ ℚ`;
* `ratVec_range_countable` — the fragment is countable;
* `eq_sum_single_of_mem_finSupport` — a finitely-supported vector is the finite
  sum of its coordinate atoms;
* `ratVec_dense` — the rational fragment is dense in `ℓ²(ℕ)`;
* `ell2_separable` — **headline**: `ℓ²(ℕ)` is separable, witnessed by the
  countable dense rational fragment.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Filter Finset
open scoped ENNReal

namespace BookProof.ChapterEll2Separable

open BookProof.ChapterRieszFischer

/-- The finitely-supported **rational** vectors of `ℓ²(ℕ)`, indexed by the
countable type `ℕ →₀ ℚ`. -/
noncomputable def ratVec (c : ℕ →₀ ℚ) : Ell2 :=
  ∑ i ∈ c.support, lp.single 2 i ((c i : ℝ))

/-- The rational fragment is countable: it is the image of the countable type
`ℕ →₀ ℚ`. -/
theorem ratVec_range_countable : (Set.range ratVec).Countable :=
  Set.countable_range _

/-- Every finite rational combination of coordinate atoms belongs to the
fragment, whatever finite index set it is written over. -/
theorem sum_single_rat_mem_range (s : Finset ℕ) (q : ℕ → ℚ) :
    (∑ i ∈ s, lp.single 2 i ((q i : ℝ))) ∈ Set.range ratVec := by
  classical
  set q' : ℕ → ℚ := fun i => if i ∈ s then q i else 0 with hq'
  refine ⟨Finsupp.onFinset s q' ?_, ?_⟩
  · intro a ha
    by_contra has
    exact ha (by simp [hq', has])
  · have hsub : (Finsupp.onFinset s q' (by
        intro a ha
        by_contra has
        exact ha (by simp [hq', has]))).support ⊆ s := Finsupp.support_onFinset_subset
    rw [ratVec]
    rw [Finset.sum_subset hsub]
    · refine Finset.sum_congr rfl fun i hi => ?_
      simp [Finsupp.onFinset_apply, hq', hi]
    · intro i _ hi
      have : q' i = 0 := by
        by_contra h
        exact hi (Finsupp.mem_support_iff.2 (by simpa [Finsupp.onFinset_apply] using h))
      simp [Finsupp.onFinset_apply, this]

/-- A finitely-supported vector of `ℓ²(ℕ)` is the *finite* sum of its coordinate
atoms over any finset containing its support. -/
theorem eq_sum_single_of_mem_finSupport (f : Ell2) {s : Finset ℕ}
    (hs : Function.support ((f : ℕ → ℝ)) ⊆ (s : Set ℕ)) :
    f = ∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i) := by
  have h₁ : HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f := riesz_fischer_hasSum f
  have h₂ : HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i))
      (∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i)) := by
    refine hasSum_sum_of_ne_finset_zero ?_
    intro i hi
    have : (f : ℕ → ℝ) i = 0 := by
      by_contra h
      exact hi (by exact_mod_cast hs h)
    simp [this]
  exact h₁.unique h₂

/-- **Density.** The countable rational fragment is dense in `ℓ²(ℕ)`. -/
theorem ratVec_dense : Dense (Set.range ratVec) := by
  classical
  rw [dense_iff_closure_eq, ← Set.univ_subset_iff]
  intro f _
  rw [mem_closure_iff_nhds_basis Metric.nhds_basis_ball]
  intro eps heps
  -- first approximate `f` by a finitely-supported vector
  obtain ⟨g, hg, hgf⟩ := Metric.mem_closure_iff.1 (finSupport_dense f) (eps / 2) (by linarith)
  set s : Finset ℕ := hg.toFinset
  have hssub : Function.support ((g : ℕ → ℝ)) ⊆ (s : Set ℕ) := by
    intro i hi
    exact Finset.mem_coe.2 ((Set.Finite.mem_toFinset hg).2 hi)
  have hgsum : g = ∑ i ∈ s, lp.single 2 i ((g : ℕ → ℝ) i) :=
    eq_sum_single_of_mem_finSupport g hssub
  -- then approximate each of the finitely many coordinates by a rational
  have hcnn : (0 : ℝ) ≤ (s.card : ℝ) := Nat.cast_nonneg _
  have hden : (0 : ℝ) < 2 * ((s.card : ℝ) + 1) := by linarith
  have hpos : (0 : ℝ) < eps / (2 * (s.card + 1)) := div_pos heps hden
  have hq : ∀ i : ℕ, ∃ q : ℚ, |(g : ℕ → ℝ) i - (q : ℝ)| < eps / (2 * (s.card + 1)) := by
    intro i
    obtain ⟨q, hq⟩ := exists_rat_near ((g : ℕ → ℝ) i) hpos
    exact ⟨q, hq⟩
  choose q hqlt using hq
  refine ⟨∑ i ∈ s, lp.single 2 i ((q i : ℝ)), sum_single_rat_mem_range s q, ?_⟩
  -- combine the two estimates
  have hbound : ‖g - ∑ i ∈ s, lp.single 2 i ((q i : ℝ))‖ ≤
      ∑ i ∈ s, ‖lp.single (E := fun _ : ℕ => ℝ) 2 i ((g : ℕ → ℝ) i - (q i : ℝ))‖ := by
    have hdiff : g - ∑ i ∈ s, lp.single 2 i ((q i : ℝ))
        = ∑ i ∈ s, lp.single 2 i ((g : ℕ → ℝ) i - (q i : ℝ)) := by
      have hsplit : ∑ i ∈ s, lp.single 2 i ((g : ℕ → ℝ) i - (q i : ℝ))
          = (∑ i ∈ s, lp.single 2 i ((g : ℕ → ℝ) i))
            - ∑ i ∈ s, lp.single 2 i ((q i : ℝ)) := by
        rw [← Finset.sum_sub_distrib]
        exact Finset.sum_congr rfl fun i _ => lp.single_sub 2 i _ _
      rw [hsplit, ← hgsum]
    rw [hdiff]
    exact norm_sum_le _ _
  have hterm : ∀ i ∈ s,
      ‖lp.single (E := fun _ : ℕ => ℝ) 2 i ((g : ℕ → ℝ) i - (q i : ℝ))‖
        ≤ eps / (2 * (s.card + 1)) := by
    intro i _
    rw [lp.norm_single (by norm_num)]
    exact le_of_lt (by simpa [Real.norm_eq_abs] using hqlt i)
  have hsum_le : ∑ i ∈ s, ‖lp.single (E := fun _ : ℕ => ℝ) 2 i
      ((g : ℕ → ℝ) i - (q i : ℝ))‖ ≤ s.card * (eps / (2 * (s.card + 1))) := by
    simpa using Finset.sum_le_card_nsmul s _ _ hterm
  have hcard : (s.card : ℝ) * (eps / (2 * (s.card + 1))) < eps / 2 := by
    rw [← mul_div_assoc, div_lt_div_iff₀ hden (by norm_num : (0:ℝ) < 2)]
    nlinarith
  have : ‖g - ∑ i ∈ s, lp.single 2 i ((q i : ℝ))‖ < eps / 2 :=
    lt_of_le_of_lt (hbound.trans hsum_le) hcard
  have hdist : dist f (∑ i ∈ s, lp.single 2 i ((q i : ℝ))) < eps := by
    have h1 : dist f g < eps / 2 := hgf
    have h2 : dist g (∑ i ∈ s, lp.single 2 i ((q i : ℝ))) < eps / 2 := by
      rwa [dist_eq_norm]
    calc dist f (∑ i ∈ s, lp.single 2 i ((q i : ℝ)))
        ≤ dist f g + dist g (∑ i ∈ s, lp.single 2 i ((q i : ℝ))) := dist_triangle _ _ _
      _ < eps / 2 + eps / 2 := by linarith
      _ = eps := by ring
  simpa [Metric.mem_ball, dist_comm] using hdist

/-- **Headline — the PA-free completion is separable.**  `ℓ²(ℕ)` is the closure
of a countable set of finitely-supported rational vectors, so it is a separable
metric space: a countable language suffices to name a dense fragment. -/
theorem ell2_separable : TopologicalSpace.SeparableSpace Ell2 :=
  ⟨⟨Set.range ratVec, ratVec_range_countable, ratVec_dense⟩⟩

end BookProof.ChapterEll2Separable
