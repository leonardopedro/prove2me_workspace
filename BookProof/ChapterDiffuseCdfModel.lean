import Mathlib

/-!
# Diffuse measures and the uniform model (plan GAP-2, the diffuse standard type)

The abelian classification list names `L∞[0,1]` — multiplication by essentially
bounded functions on the unit interval with Lebesgue measure — as the *diffuse*
standard type.  `ChapterMeasureAtomicDiffuse` splits every summand measure of the
abelian multiplication model into a purely atomic and a diffuse part; the diffuse
part still has to be recognised as the uniform measure.  This module proves the
measure-theoretic half of that recognition on the real line:

* `continuous_cdf_of_noAtoms` — the cumulative distribution function of an atomless
  probability measure is continuous (a jump of `F` at `a` *is* the mass of `{a}`);
* `exists_cdf_eq` — consequently `F` takes every value in `(0, 1)`, since it tends to
  `0` at `-∞` and to `1` at `+∞`;
* `measure_cdf_le` — the key computation `μ{x : F x ≤ t} = t` for `0 ≤ t < 1`;
* HEADLINE `map_cdf_eq_volume_Icc` — **the distribution function pushes an atomless
  probability measure forward to the uniform measure**:
  `(F)_* μ = volume|[0,1]`.

So every diffuse probability measure on `ℝ` is, through its own distribution
function, a copy of Lebesgue measure on the unit interval — the standard diffuse
model of the classification list.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ProbabilityTheory Filter

namespace BookProof.ChapterDiffuseCdfModel

variable (mu : Measure ℝ)

/-! ## 1. The distribution function of a diffuse measure is continuous -/

/-- **The distribution function of an atomless measure is continuous.**  For a
monotone right-continuous function continuity at `a` means that the left limit agrees
with the value, and that difference is exactly the mass of the singleton `{a}`. -/
theorem continuous_cdf_of_noAtoms [IsProbabilityMeasure mu] [NoAtoms mu] :
    Continuous (cdf mu) := by
  refine continuous_iff_continuousAt.2 fun a => ?_
  have hmono : Monotone (cdf mu) := (cdf mu).mono
  have hs : (cdf mu).measure {a} = 0 := by
    rw [measure_cdf]
    simp
  have h1 : ENNReal.ofReal ((cdf mu) a - Function.leftLim (cdf mu) a) = 0 := by
    rw [← StieltjesFunction.measure_singleton]
    exact hs
  have h2 : (cdf mu) a ≤ Function.leftLim (cdf mu) a := by
    have h := (ENNReal.ofReal_eq_zero).1 h1
    linarith
  have h3 : Function.leftLim (cdf mu) a ≤ (cdf mu) a := hmono.leftLim_le le_rfl
  have hleft : Function.leftLim (cdf mu) a = (cdf mu) a := le_antisymm h3 h2
  have hright : Function.rightLim (cdf mu) a = (cdf mu) a :=
    ((cdf mu).right_continuous a).rightLim_eq
  rw [hmono.continuousAt_iff_leftLim_eq_rightLim, hleft, hright]

/-- **Every level in `(0, 1)` is attained** by the distribution function of a diffuse
probability measure. -/
theorem exists_cdf_eq [IsProbabilityMeasure mu] [NoAtoms mu] {t : ℝ} (ht0 : 0 < t)
    (ht1 : t < 1) : ∃ x : ℝ, cdf mu x = t := by
  have hc : Continuous (cdf mu) := continuous_cdf_of_noAtoms mu
  obtain ⟨a, ha⟩ := ((tendsto_cdf_atBot mu).eventually (eventually_lt_nhds ht0)).exists
  obtain ⟨b, hb⟩ := ((tendsto_cdf_atTop mu).eventually (eventually_gt_nhds ht1)).exists
  rcases le_total a b with hab | hab
  · obtain ⟨x, -, hx⟩ :=
      intermediate_value_Icc hab hc.continuousOn ⟨le_of_lt ha, le_of_lt hb⟩
    exact ⟨x, hx⟩
  · obtain ⟨x, -, hx⟩ :=
      intermediate_value_Icc' hab hc.continuousOn ⟨le_of_lt ha, le_of_lt hb⟩
    exact ⟨x, hx⟩

/-! ## 2. The level sets have the right mass -/

/-- **The key computation.**  For `0 ≤ t < 1` the sublevel set `{F ≤ t}` of the
distribution function of a diffuse probability measure has mass exactly `t`.  The
lower bound comes from a point `x` with `F x = t` (the sublevel set contains
`(-∞, x]`); the upper bound from points at slightly higher levels `s ↓ t` (the
sublevel set is contained in `(-∞, y]` whenever `F y = s > t`). -/
theorem measure_cdf_le [IsProbabilityMeasure mu] [NoAtoms mu] {t : ℝ} (ht0 : 0 ≤ t)
    (ht1 : t < 1) : mu {x | cdf mu x ≤ t} = ENNReal.ofReal t := by
  refine le_antisymm ?_ ?_
  · have key : ∀ s : ℝ, t < s → s < 1 → mu {x | cdf mu x ≤ t} ≤ ENNReal.ofReal s := by
      intro s hts hs1
      obtain ⟨y, hy⟩ := exists_cdf_eq mu (lt_of_le_of_lt ht0 hts) hs1
      have hsub : {x : ℝ | cdf mu x ≤ t} ⊆ Set.Iic y := by
        intro z hz
        by_contra hzy
        have hyz : y < z := lt_of_not_ge hzy
        have hmono := (cdf mu).mono hyz.le
        rw [hy] at hmono
        exact absurd (le_trans hmono hz) (by linarith)
      calc mu {x | cdf mu x ≤ t} ≤ mu (Set.Iic y) := measure_mono hsub
        _ = ENNReal.ofReal (cdf mu y) := (ofReal_cdf mu y).symm
        _ = ENNReal.ofReal s := by rw [hy]
    have hlim : Tendsto (fun s : ℝ => ENNReal.ofReal s) (nhdsWithin t (Set.Ioi t))
        (nhds (ENNReal.ofReal t)) :=
      (ENNReal.continuous_ofReal.tendsto t).mono_left nhdsWithin_le_nhds
    refine ge_of_tendsto hlim ?_
    filter_upwards [self_mem_nhdsWithin, Ioo_mem_nhdsGT ht1] with s hs hs1
    exact key s hs hs1.2
  · rcases eq_or_lt_of_le ht0 with h | h
    · simp [← h]
    · obtain ⟨x, hx⟩ := exists_cdf_eq mu h ht1
      have hsub : Set.Iic x ⊆ {y : ℝ | cdf mu y ≤ t} := by
        intro z hz
        have hm := (cdf mu).mono hz
        rw [hx] at hm
        exact hm
      calc ENNReal.ofReal t = ENNReal.ofReal (cdf mu x) := by rw [hx]
        _ = mu (Set.Iic x) := ofReal_cdf mu x
        _ ≤ mu {y | cdf mu y ≤ t} := measure_mono hsub

/-! ## 3. The uniform model -/

theorem volume_Icc_inter_Iic {t : ℝ} (ht1 : t ≤ 1) :
    (volume.restrict (Set.Icc (0 : ℝ) 1)) (Set.Iic t) = ENNReal.ofReal t := by
  rw [Measure.restrict_apply measurableSet_Iic]
  have hset : Set.Iic t ∩ Set.Icc (0 : ℝ) 1 = Set.Icc 0 t := by
    ext y
    simp only [Set.mem_inter_iff, Set.mem_Iic, Set.mem_Icc]
    constructor
    · rintro ⟨h1, h2, -⟩
      exact ⟨h2, h1⟩
    · rintro ⟨h1, h2⟩
      exact ⟨h2, h1, by linarith⟩
  rw [hset, Real.volume_Icc]
  simp

/-- **HEADLINE (the diffuse standard model).**  The distribution function of an
atomless Borel probability measure on `ℝ` pushes it forward to the **uniform**
measure on `[0, 1]`: every diffuse probability measure on the line is a copy of
Lebesgue measure on the unit interval, read through its own distribution function. -/
theorem map_cdf_eq_volume_Icc [IsProbabilityMeasure mu] [NoAtoms mu] :
    Measure.map (cdf mu) mu = volume.restrict (Set.Icc (0 : ℝ) 1) := by
  have hmeas : Measurable (cdf mu) := (cdf mu).mono.measurable
  refine Measure.ext_of_Iic _ _ fun t => ?_
  rw [Measure.map_apply hmeas measurableSet_Iic]
  have hpre : (cdf mu) ⁻¹' Set.Iic t = {x : ℝ | cdf mu x ≤ t} := rfl
  rw [hpre]
  rcases lt_trichotomy t 0 with ht | ht | ht
  · have hempty : {x : ℝ | cdf mu x ≤ t} = ∅ := by
      ext x
      simp only [Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, not_le]
      exact lt_of_lt_of_le ht (cdf_nonneg mu x)
    have hempty' : Set.Iic t ∩ Set.Icc (0 : ℝ) 1 = ∅ := by
      refine Set.eq_empty_iff_forall_notMem.2 fun y hy => ?_
      obtain ⟨hy1, hy0, -⟩ := hy
      exact absurd (le_trans hy0 hy1) (by linarith)
    rw [hempty, Measure.restrict_apply measurableSet_Iic, hempty']
    simp
  · subst ht
    rw [measure_cdf_le mu le_rfl one_pos, volume_Icc_inter_Iic zero_le_one]
  · rcases lt_or_ge t 1 with ht1 | ht1
    · rw [measure_cdf_le mu ht.le ht1, volume_Icc_inter_Iic ht1.le]
    · have huniv : {x : ℝ | cdf mu x ≤ t} = Set.univ := by
        ext x
        simp only [Set.mem_setOf_eq, Set.mem_univ, iff_true]
        exact le_trans (cdf_le_one mu x) ht1
      have hIcc : Set.Iic t ∩ Set.Icc (0 : ℝ) 1 = Set.Icc 0 1 := by
        ext y
        simp only [Set.mem_inter_iff, Set.mem_Iic, Set.mem_Icc]
        constructor
        · rintro ⟨-, hy⟩
          exact hy
        · rintro ⟨hy0, hy1⟩
          exact ⟨le_trans hy1 ht1, hy0, hy1⟩
      rw [huniv, Measure.restrict_apply measurableSet_Iic, hIcc, Real.volume_Icc,
        measure_univ]
      simp

end BookProof.ChapterDiffuseCdfModel

end
