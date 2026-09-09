import Mathlib
import BookProof.ChapterLinftyMultiplication

/-!
# `L∞(μ)` is *maximal* abelian on `L²(μ)` — the diffuse half of the classification

`ChapterLinftyMultiplication` builds the diffuse model of the abelian
classification: for essentially bounded `φ : α → ℂ` the multiplication operators
`multOp φ : L²(μ) →L[ℂ] L²(μ)` form a unital, abelian, star-closed and faithful
algebra.  `ChapterAbelianAtomicCondensation` proves the *atomic* condensation:
a purely atomic maximal abelian algebra **is** the diagonal algebra `ℓ∞`.

This module proves the matching statement for the diffuse model, which is the
structural fact the classification actually rests on:

  **the multiplication algebra is its own commutant.**

Concretely (`commutant_eq_multOp`), on a finite measure space every bounded
operator `T` on `L²(μ)` that commutes with *every* multiplication operator is
itself a multiplication operator `T = multOp ψ`, and its symbol is
`ψ = T(1)` with `‖ψ‖_∞ ≤ ‖T‖` (`symbol_ae_norm_le`,
`memLp_top_symbol`).  Hence the algebra is **maximal abelian**
(`multOp_algebra_maximal_abelian`): no bounded operator can be adjoined to it
without breaking commutativity.  Specialized to Lebesgue measure on `[0,1]`
(`unitInterval_multOp_maximal_abelian`) this is the diffuse companion of the
atomic condensation — the two ends of the classification list.

The proof is the classical one:

* `symbol T := T(1)` makes sense because `1 ∈ L²(μ)` for a finite measure;
* `symbol_mul` — commutation gives `T(φ) = φ · ψ` for every bounded `φ`;
* `symbol_ae_norm_le` — testing on the indicator of `{‖ψ‖ ≥ ‖T‖ + ε}` and
  comparing the two `L²` norms forces that set to be null, so `ψ ∈ L∞(μ)`;
* `commutant_eq_multOp` — `T` and `multOp ψ` are continuous and agree on the
  indicator functions, hence everywhere, by `Lp.induction`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ENNReal Complex

namespace BookProof.ChapterLinftyMaximalAbelian

open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

/-- The constant function `1`, as an element of `L²(μ)` (available because `μ`
is finite).  It is the cyclic vector of the multiplication algebra. -/
def oneLp (μ : Measure α) [IsFiniteMeasure μ] : Lp ℂ 2 μ :=
  MemLp.toLp (fun _ : α => (1 : ℂ)) (memLp_const 1)

theorem oneLp_coeFn : (oneLp μ : α → ℂ) =ᵐ[μ] fun _ => (1 : ℂ) :=
  MemLp.coeFn_toLp _

/-- The **symbol** of an operator: a strongly measurable representative of
`T(1)`.  For a `T` commuting with all multiplications this is the essentially
bounded function that `T` multiplies by. -/
def symbol (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) : α → ℂ :=
  (Lp.aestronglyMeasurable (T (oneLp μ))).mk _

theorem stronglyMeasurable_symbol (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) :
    StronglyMeasurable (symbol T) :=
  (Lp.aestronglyMeasurable (T (oneLp μ))).stronglyMeasurable_mk

theorem symbol_ae_eq (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) :
    (T (oneLp μ) : α → ℂ) =ᵐ[μ] symbol T :=
  (Lp.aestronglyMeasurable (T (oneLp μ))).ae_eq_mk

/-- An operator commuting with every multiplication operator. -/
def CommutesWithMultOps (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) : Prop :=
  ∀ (φ : α → ℂ) (hφ : MemLp φ ⊤ μ), T.comp (multOp φ hφ) = (multOp φ hφ).comp T

/-- **Commutation determines `T` on bounded functions**: `T(φ·1) = φ·ψ`. -/
theorem symbol_mul {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T)
    (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    ((T (multOp φ hφ (oneLp μ))) : α → ℂ) =ᵐ[μ] fun x => φ x * symbol T x := by
  have h := congrArg (fun S : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ => S (oneLp μ)) (hT φ hφ)
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at h
  rw [h]
  filter_upwards [multOp_coeFn φ hφ (T (oneLp μ)), symbol_ae_eq T] with x h1 h2
  rw [h1, h2]

/-- The `L²` element `φ · 1` for the indicator of a measurable set. -/
theorem multOp_indicator_oneLp {s : Set α} (hs : MeasurableSet s) (c : ℂ) :
    multOp (s.indicator fun _ => c) ((memLp_top_const c).indicator hs) (oneLp μ)
      = indicatorConstLp 2 hs (measure_ne_top μ s) c := by
  refine Lp.ext ?_
  filter_upwards [multOp_coeFn (s.indicator fun _ => c) ((memLp_top_const c).indicator hs)
      (oneLp μ), oneLp_coeFn (μ := μ),
    indicatorConstLp_coeFn (p := (2 : ℝ≥0∞)) (hs := hs) (hμs := measure_ne_top μ s) (c := c)]
    with x h1 h2 h3
  rw [h1, h2, h3, mul_one]

/-- **The symbol is essentially bounded by the operator norm.** -/
theorem symbol_ae_norm_le {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    ∀ᵐ x ∂μ, ‖symbol T x‖ ≤ ‖T‖ := by
  set c : ℝ := ‖T‖ with hc
  -- for each `n`, the set where `‖ψ‖ ≥ c + 1/(n+1)` is null
  have key : ∀ n : ℕ, μ {x | c + 1 / (n + 1 : ℝ) ≤ ‖symbol T x‖} = 0 := by
    intro n
    set ε : ℝ := 1 / (n + 1 : ℝ) with hε
    have hεpos : 0 < ε := by positivity
    set s : Set α := {x | c + ε ≤ ‖symbol T x‖} with hsdef
    have hs : MeasurableSet s := by
      have : Measurable fun x => ‖symbol T x‖ :=
        (stronglyMeasurable_symbol T).measurable.norm
      exact measurableSet_le measurable_const this
    set φ : α → ℂ := s.indicator fun _ => (1 : ℂ) with hφdef
    have hφ : MemLp φ ⊤ μ := (memLp_top_const (1 : ℂ)).indicator hs
    set u : Lp ℂ 2 μ := multOp φ hφ (oneLp μ) with hu
    have hu_eq : u = indicatorConstLp 2 hs (measure_ne_top μ s) (1 : ℂ) :=
      multOp_indicator_oneLp hs 1
    have hnorm_u : ‖u‖ = μ.real s ^ (1 / (2 : ℝ)) := by
      rw [hu_eq, norm_indicatorConstLp (by norm_num) (by norm_num)]
      simp
    -- the lower bound: `|T u| ≥ (c+ε)·1_s` pointwise
    have hlow : ‖indicatorConstLp 2 hs (measure_ne_top μ s) ((c + ε : ℝ) : ℂ)‖ ≤ ‖T u‖ := by
      refine Lp.norm_le_norm_of_ae_le ?_
      filter_upwards [indicatorConstLp_coeFn (p := (2 : ℝ≥0∞)) (hs := hs)
          (hμs := measure_ne_top μ s) (c := ((c + ε : ℝ) : ℂ)), symbol_mul hT φ hφ] with x h1 h2
      rw [h1, h2]
      by_cases hx : x ∈ s
      · have hmem : c + ε ≤ ‖symbol T x‖ := hx
        have hnn : (0 : ℝ) ≤ c + ε := by rw [hc]; positivity
        rw [Set.indicator_of_mem hx, hφdef, Set.indicator_of_mem hx, one_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hnn]
        exact hmem
      · simp [Set.indicator_of_notMem hx, hφdef]
    have hupper : ‖T u‖ ≤ c * μ.real s ^ (1 / (2 : ℝ)) := by
      calc ‖T u‖ ≤ ‖T‖ * ‖u‖ := T.le_opNorm u
        _ = c * μ.real s ^ (1 / (2 : ℝ)) := by rw [hnorm_u]
    have hlow' : (c + ε) * μ.real s ^ (1 / (2 : ℝ)) ≤ c * μ.real s ^ (1 / (2 : ℝ)) := by
      have := hlow.trans hupper
      rwa [norm_indicatorConstLp (by norm_num) (by norm_num), Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (by positivity)] at this
    have hzero : μ.real s ^ (1 / (2 : ℝ)) ≤ 0 := by nlinarith [hεpos]
    have hpow : μ.real s ^ (1 / (2 : ℝ)) = 0 :=
      le_antisymm hzero (Real.rpow_nonneg (measureReal_nonneg) _)
    have : μ.real s = 0 := by
      by_contra h
      have hpos : 0 < μ.real s := lt_of_le_of_ne measureReal_nonneg (Ne.symm h)
      exact absurd hpow (ne_of_gt (Real.rpow_pos_of_pos hpos _))
    exact (measureReal_eq_zero_iff (measure_ne_top μ s)).mp this
  -- union over `n`
  have : μ {x | ¬ ‖symbol T x‖ ≤ c} = 0 := by
    have hsub : {x | ¬ ‖symbol T x‖ ≤ c}
        ⊆ ⋃ n : ℕ, {x | c + 1 / (n + 1 : ℝ) ≤ ‖symbol T x‖} := by
      intro x hx
      simp only [Set.mem_setOf_eq, not_le] at hx
      obtain ⟨n, hn⟩ := exists_nat_one_div_lt (sub_pos.mpr hx)
      exact Set.mem_iUnion.mpr ⟨n, by simp only [Set.mem_setOf_eq]; linarith⟩
    exact measure_mono_null hsub (measure_iUnion_null key)
  simpa [ae_iff] using this

/-- The symbol of a commuting operator is essentially bounded. -/
theorem memLp_top_symbol {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    MemLp (symbol T) ⊤ μ :=
  memLp_top_of_bound (stronglyMeasurable_symbol T).aestronglyMeasurable ‖T‖
    (symbol_ae_norm_le hT)

/-- **The commutant of the multiplication algebra is the multiplication
algebra.**  On a finite measure space, a bounded operator on `L²(μ)` commuting
with every multiplication operator is multiplication by its own symbol. -/
theorem commutant_eq_multOp {T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ} (hT : CommutesWithMultOps T) :
    T = multOp (symbol T) (memLp_top_symbol hT) := by
  have hψ := memLp_top_symbol hT
  refine ContinuousLinearMap.ext ?_
  refine Lp.induction (p := (2 : ℝ≥0∞)) (by norm_num)
    (motive := fun f => T f = multOp (symbol T) hψ f) ?_ ?_ ?_
  · intro c s hs hμs
    have hcoe : ((Lp.simpleFunc.indicatorConst 2 hs hμs.ne c : Lp.simpleFunc ℂ 2 μ) : Lp ℂ 2 μ)
        = indicatorConstLp 2 hs hμs.ne c := Lp.simpleFunc.coe_indicatorConst hs hμs.ne c
    rw [hcoe]
    have hind : indicatorConstLp 2 hs (measure_ne_top μ s) c
        = multOp (s.indicator fun _ => c) ((memLp_top_const c).indicator hs) (oneLp μ) :=
      (multOp_indicator_oneLp hs c).symm
    refine Lp.ext ?_
    rw [hind]
    filter_upwards [symbol_mul hT (s.indicator fun _ => c) ((memLp_top_const c).indicator hs),
      multOp_coeFn (symbol T) hψ
        (multOp (s.indicator fun _ => c) ((memLp_top_const c).indicator hs) (oneLp μ)),
      multOp_coeFn (s.indicator fun _ => c) ((memLp_top_const c).indicator hs) (oneLp μ),
      oneLp_coeFn (μ := μ)] with x h1 h2 h3 h4
    rw [h1, h2, h3, h4, mul_one, mul_comm]
  · intro f g hf hg _ hfm hgm
    rw [map_add, map_add, hfm, hgm]
  · exact isClosed_eq T.continuous (multOp (symbol T) hψ).continuous

/-- **Maximal abelianness.**  If a bounded operator commutes with every element
of the multiplication algebra, then it belongs to that algebra: there is an
essentially bounded symbol `ψ` with `T = multOp ψ`.  Equivalently, the abelian
algebra `L∞(μ)` acting on `L²(μ)` admits no proper abelian extension inside
`B(L²(μ))`. -/
theorem multOp_algebra_maximal_abelian (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ)
    (hT : CommutesWithMultOps T) :
    ∃ (ψ : α → ℂ) (hψ : MemLp ψ ⊤ μ), T = multOp ψ hψ :=
  ⟨symbol T, memLp_top_symbol hT, commutant_eq_multOp hT⟩

/-- **The diffuse model is maximal abelian.**  Lebesgue measure on `[0,1]` is
atomless (`ChapterLinftyMultiplication.unitInterval_atomless`), and its
multiplication algebra on `L²[0,1]` is its own commutant.  This is the diffuse
counterpart of `ChapterAbelianAtomicCondensation.atomic_abelian_maximal_eq_diagonal`:
at the atomic end a maximal abelian algebra is the diagonal `ℓ∞`, at the diffuse
end it is `L∞` acting by multiplication. -/
theorem unitInterval_multOp_maximal_abelian
    (T : Lp ℂ 2 (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)) →L[ℂ]
      Lp ℂ 2 (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)))
    (hT : CommutesWithMultOps T) :
    ∃ (ψ : ℝ → ℂ) (hψ : MemLp ψ ⊤ (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1))),
      T = multOp ψ hψ :=
  multOp_algebra_maximal_abelian T hT

end BookProof.ChapterLinftyMaximalAbelian

end
