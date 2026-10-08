import Mathlib


/-!
# Part 1: Foundations — measure theory

This file formalizes the measure-theoretic foundations (F1–F8) of the
`pnp.tex` formalization plan.
-/

open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

namespace PhysMeasureBasis

/-- The unit interval as a measure space: Lebesgue restricted to [0,1]. -/
abbrev unitMeasure : Measure ℝ := volume.restrict (Icc (0:ℝ) 1)

/-- The unit square with Lebesgue measure. -/
abbrev squareMeasure : Measure (ℝ × ℝ) :=
  volume.restrict (Icc (0:ℝ) 1 ×ˢ Icc (0:ℝ) 1)

instance : IsProbabilityMeasure unitMeasure := by
  constructor ; norm_num

instance : IsProbabilityMeasure squareMeasure := by
  constructor;
  erw [ MeasureTheory.Measure.restrict_apply_univ ] ; ring ;
  erw [ MeasureTheory.Measure.prod_prod ] ; norm_num

/-! ### F1. Points are null in continuous probability spaces -/





/-! ### F2. Countable sets are null -/



/-! ### F3. Selection exists: disintegration / regular conditional probability -/



/-! ### F4. No complete history realizes the selected event -/



/-! ### F5. A finite measure has countably many point atoms -/



/-! ### F6. Continuous and atomic parts are mutually singular -/

pnp.tex` formalization plan.
-/

open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

namespace PhysMeasureBasis

/-- The unit interval as a measure space: Lebesgue restricted to [0,1]. -/
abbrev unitMeasure : Measure ℝ := volume.restrict (Icc (0:ℝ) 1)

/-- The unit square with Lebesgue measure. -/
abbrev squareMeasure : Measure (ℝ × ℝ) :=
  volume.restrict (Icc (0:ℝ) 1 ×ˢ Icc (0:ℝ) 1)

instance : IsProbabilityMeasure unitMeasure := by
  constructor ; norm_num

instance : IsProbabilityMeasure squareMeasure := by
  constructor;
  erw [ MeasureTheory.Measure.restrict_apply_univ ] ; ring ;
  erw [ MeasureTheory.Measure.prod_prod ] ; norm_num

/-! ### F1. Points are null in continuous probability spaces -/

theorem null_singleton_volume (y : ℝ) : volume ({y} : Set ℝ) = 0 := by
  norm_num +zetaDelta at *

theorem null_singleton {α : Type*} [MeasurableSpace α] (μ : Measure α)
    [MeasurableSingletonClass α] [NullSingletonClass μ] (a : α) : μ {a} = 0 := by
  convert MeasureTheory.NullSingletonClass.measure_singleton a;
  infer_instance

/-! ### F2. Countable sets are null -/

theorem countable_null {α : Type*} [MeasurableSpace α]
    [MeasurableSingletonClass α] (μ : Measure α) [NullSingletonClass μ]
    {s : Set α} (hs : s.Countable) : μ s = 0 := by
  convert Set.Countable.measure_zero hs μ

/-! ### F3. Selection exists: disintegration / regular conditional probability -/

theorem selection_exists :
    squareMeasure.fst ⊗ₘ squareMeasure.condKernel = squareMeasure :=
  Measure.disintegrate _ _

/-! ### F4. No complete history realizes the selected event -/

theorem no_history {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    [IsProbabilityMeasure P] (Y : ℕ → Ω → ℝ) (_hY : ∀ n, Measurable (Y n))
    (hlaw : ∀ n, ∀ y : ℝ, P {ω | Y n ω = y} = 0) (y₀ : ℝ) :
    P {ω | ∃ n, Y n ω = y₀} = 0 := by
  rw [ show { ω | ∃ n, Y n ω = y₀ } = ⋃ n, { ω | Y n ω = y₀ } by ext; aesop ]
  exact MeasureTheory.measure_iUnion_null fun n => hlaw n y₀

/-! ### F5. A finite measure has countably many point atoms -/

theorem countable_atoms {α : Type*} [MeasurableSpace α]
    [MeasurableSingletonClass α] (μ : Measure α) [IsFiniteMeasure μ] :
    {x | μ {x} ≠ 0}.Countable := by
  by_contra! h;
  -- Since μ is finite, there exists some ε > 0 such that the set {x | μ {x} > ε} is uncountable.
  obtain ⟨ε, hε_pos, hε_uncountable⟩ : ∃ ε > 0, ¬Set.Countable {x : α | μ {x} > ε} := by
    by_cases hε : ∀ ε > 0, Set.Countable {x : α | μ {x} > ε};
    · refine False.elim (h ?_)
      convert Set.countable_iUnion fun n : ℕ => hε (1 / (n + 1)) (by simp +decide) using 1
      ext x
      simp only [ne_eq, mem_setOf_eq, one_div, gt_iff_lt, mem_iUnion]
      constructor <;> intro hx
      · rcases ENNReal.exists_inv_nat_lt hx with ⟨ n, hn ⟩;
        exact ⟨ n, lt_of_le_of_lt ( by simp ) hn ⟩;
      · exact ne_of_gt ( lt_of_le_of_lt ( by positivity ) hx.choose_spec );
    · exact by push_neg at hε; exact hε;
  -- Since {x | μ {x} > ε} is uncountable, we can find an infinite subset of it.
  obtain ⟨s, hs_inf, hs_subset⟩ : ∃ s : Set α, s.Infinite ∧ s ⊆ {x : α | μ {x} > ε} := by
    exact ⟨ _, fun h => hε_uncountable <| h.countable, Set.Subset.refl _ ⟩;
  -- Since $s$ is infinite, we can find a finite subset $t$ of $s$ such that $\mu(t) > \mu(\alpha)$.
  obtain ⟨t, ht_finite, ht_subset⟩ : ∃ t : Finset α, t.card > μ Set.univ / ε ∧ ∀ x ∈ t, x ∈ s := by
    rcases ENNReal.lt_iff_exists_real_btwn.mp (show μ Set.univ / ε < ⊤ from
      ENNReal.div_lt_top (MeasureTheory.measure_ne_top _ _) hε_pos.ne') with ⟨r, hr⟩;
    rcases exists_nat_gt r with ⟨ n, hn ⟩;
    rcases hs_inf.exists_subset_card_eq n with ⟨ t, ht ⟩;
    exact ⟨t, lt_of_lt_of_le hr.2.1
      (le_trans (ENNReal.ofReal_le_ofReal hn.le) (by simp +decide [ht.2])), fun x hx => ht.1 hx⟩;
  -- Since $t$ is a finite subset of $s$, we have $\mu(t) \geq t.card \cdot \epsilon$.
  have ht_measure : μ (t : Set α) ≥ t.card * ε := by
    have ht_measure : μ (t : Set α) ≥ ∑ x ∈ t, μ {x} := by
      rw [ ← MeasureTheory.measure_biUnion_finset ];
      · exact MeasureTheory.measure_mono ( by aesop_cat );
      · exact fun x hx y hy hxy => Set.disjoint_singleton.2 hxy;
      · exact fun x hx => MeasurableSingletonClass.measurableSet_singleton x;
    exact le_trans (by simp +decide [mul_comm]) (ht_measure.trans'
      (Finset.sum_le_sum fun x hx => le_of_lt (hs_subset (ht_subset x hx))));
  rw [gt_iff_lt, ENNReal.div_lt_iff] at ht_finite <;>
    simp_all +decide only [ne_eq, gt_iff_lt, mul_comm, ge_iff_le,
      Measure.measure_univ_eq_zero, measure_ne_top, not_false_eq_true, or_true]
  · exact ht_finite.not_ge
      (ht_measure.trans (MeasureTheory.measure_mono (Set.subset_univ _)));
  · aesop

/-! ### F6. Continuous and atomic parts are mutually singular -/

theorem atomless_mutuallySingular_atomic {α : Type*} [MeasurableSpace α]
    [MeasurableSingletonClass α] (μ ν : Measure α) [NullSingletonClass μ]
    {A : Set α} (hA : A.Countable) (hν : ν Aᶜ = 0) :
    μ ⟂ₘ ν := by
  refine ⟨A, ?_, ?_⟩
  · exact hA.measurableSet;
  · exact ⟨ hA.measure_zero μ, hν ⟩

/-! ### F7. A jump separates a mixed CDF from a continuous one -/

theorem cdf_jump_separation (F G : ℝ → ℝ) (_hF : Monotone F) (_hG : Monotone G)
    (x₀ : ℝ) (hFc : ContinuousAt F x₀) (ε : ℝ) (hε : 0 < ε)
    (hjump : ∀ a b : ℝ, a < x₀ → x₀ < b → G b - G a ≥ ε) :
    ∃ a b : ℚ, (a:ℝ) < b ∧ |(G b - G a) - (F b - F a)| ≥ ε / 2 := by
  have := Metric.continuousAt_iff.mp hFc ( ε / 4 ) ( by positivity );
  obtain ⟨ δ, δ_pos, H ⟩ := this
  rcases exists_rat_btwn ( show x₀ - δ < x₀ by linarith ) with ⟨ a, ha₁, ha₂ ⟩
  rcases exists_rat_btwn ( show x₀ < x₀ + δ by linarith ) with ⟨ b, hb₁, hb₂ ⟩
  use a, b
  norm_num
  refine ⟨by exact_mod_cast ha₂.trans hb₁, ?_⟩
  cases abs_cases (G b - G a - (F b - F a)) <;>
    linarith [hjump a b ha₂ hb₁,
      abs_lt.mp (H (show |↑a - x₀| < δ from abs_lt.mpr ⟨by linarith, by linarith⟩)),
      abs_lt.mp (H (show |↑b - x₀| < δ from abs_lt.mpr ⟨by linarith, by linarith⟩))]

/-! ### F8. Conditioning a mixed measure on its diffuse part -/



end PhysMeasureBasis
