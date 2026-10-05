-- Generated from ChapterSpectralCommutant.lean — solution of BookProof.ChapterSpectralCommutant.contSymbol_ae_norm_le
import Mathlib
import Definitions.Def_ChapterSpectralCommutant
import Theorems.Thm_BookProof_ChapterSpectralCommutant_contSymbol_mul
import Theorems.Thm_BookProof_ChapterSpectralCommutant_multOp_norm_le_of_toLp
open BookProof.ChapterSpectralCommutant



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication BookProof.ChapterLinftyMaximalAbelian
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}
variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X] {mu : Measure X} [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution {S : Lp ℂ 2 mu →L[ℂ] Lp ℂ 2 mu} (hS : CommutesWithContMult S) :
    ∀ᵐ x ∂mu, ‖symbol S x‖ ≤ ‖S‖ := by

  set c : ℝ := ‖S‖ with hc
  have key : ∀ n m : ℕ,
      mu {x | c + 1 / (n + 1 : ℝ) ≤ ‖symbol S x‖ ∧ ‖symbol S x‖ ≤ (m : ℝ)} = 0 := by
    intro n m
    set ε : ℝ := 1 / (n + 1 : ℝ) with hε
    have hεpos : 0 < ε := by positivity
    set s : Set X := {x | c + ε ≤ ‖symbol S x‖ ∧ ‖symbol S x‖ ≤ (m : ℝ)} with hsdef
    have hmeas : Measurable fun x => ‖symbol S x‖ :=
      (stronglyMeasurable_symbol S).measurable.norm
    have hs : MeasurableSet s :=
      (measurableSet_le measurable_const hmeas).inter (measurableSet_le hmeas measurable_const)
    -- the truncated symbol
    set φ : X → ℂ := s.indicator (symbol S) with hφdef
    have hφ : MemLp φ ⊤ mu := by
      refine memLp_top_of_bound
        (((stronglyMeasurable_symbol S).indicator hs).aestronglyMeasurable) (m : ℝ)
        (.of_forall fun x => ?_)
      by_cases hx : x ∈ s
      · rw [hφdef, Set.indicator_of_mem hx]
        exact hx.2
      · rw [hφdef, Set.indicator_of_notMem hx]
        simp
    -- the bound on continuous test functions
    have hcont : ∀ g : C(X, ℂ), ‖multOp φ hφ (ContinuousMap.toLp 2 mu ℂ g)‖
        ≤ c * ‖ContinuousMap.toLp 2 mu ℂ g‖ := by
      intro g
      have h1 : ‖multOp φ hφ (ContinuousMap.toLp 2 mu ℂ g)‖
          ≤ ‖S (ContinuousMap.toLp 2 mu ℂ g)‖ := by
        refine Lp.norm_le_norm_of_ae_le ?_
        filter_upwards [multOp_coeFn φ hφ (ContinuousMap.toLp 2 mu ℂ g),
          ContinuousMap.coeFn_toLp (p := 2) mu (𝕜 := ℂ) g, contSymbol_mul hS g] with x h2 h3 h4
        rw [h2, h3, h4]
        by_cases hx : x ∈ s
        · rw [hφdef, Set.indicator_of_mem hx, mul_comm]
        · rw [hφdef, Set.indicator_of_notMem hx]
          simp only [zero_mul, norm_zero, norm_mul]
          positivity
      exact h1.trans (S.le_opNorm _)
    have hall := multOp_norm_le_of_toLp hφ hcont
    -- test on the indicator of `s`
    obtain ⟨u, hu⟩ : ∃ u : Lp ℂ 2 mu, u = indicatorConstLp 2 hs (measure_ne_top mu s) (1 : ℂ) :=
      ⟨_, rfl⟩
    have hnorm_u : ‖u‖ = mu.real s ^ (1 / (2 : ℝ)) := by
      rw [hu, norm_indicatorConstLp (by norm_num) (by norm_num)]
      simp
    have hlow : ‖indicatorConstLp 2 hs (measure_ne_top mu s) ((c + ε : ℝ) : ℂ)‖
        ≤ ‖multOp φ hφ u‖ := by
      refine Lp.norm_le_norm_of_ae_le ?_
      filter_upwards [indicatorConstLp_coeFn (p := (2 : ℝ≥0∞)) (hs := hs)
          (hμs := measure_ne_top mu s) (c := ((c + ε : ℝ) : ℂ)),
        multOp_coeFn φ hφ u,
        indicatorConstLp_coeFn (p := (2 : ℝ≥0∞)) (hs := hs)
          (hμs := measure_ne_top mu s) (c := (1 : ℂ))] with x h1 h2 h3
      rw [h1, h2, hu, h3]
      by_cases hx : x ∈ s
      · have hnn : (0 : ℝ) ≤ c + ε := by rw [hc]; positivity
        rw [Set.indicator_of_mem hx, Set.indicator_of_mem hx, hφdef,
          Set.indicator_of_mem hx, mul_one, Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg hnn]
        exact hx.1
      · rw [Set.indicator_of_notMem hx]
        simp only [norm_zero]
        positivity
    have hupper : ‖multOp φ hφ u‖ ≤ c * mu.real s ^ (1 / (2 : ℝ)) := by
      have := hall u
      rwa [hnorm_u] at this
    have hlow' : (c + ε) * mu.real s ^ (1 / (2 : ℝ)) ≤ c * mu.real s ^ (1 / (2 : ℝ)) := by
      have h := hlow.trans hupper
      rwa [norm_indicatorConstLp (by norm_num) (by norm_num), Complex.norm_real,
        Real.norm_eq_abs, abs_of_nonneg (by positivity)] at h
    have hzero : mu.real s ^ (1 / (2 : ℝ)) ≤ 0 := by nlinarith [hεpos]
    have hpow : mu.real s ^ (1 / (2 : ℝ)) = 0 :=
      le_antisymm hzero (Real.rpow_nonneg measureReal_nonneg _)
    have hms : mu.real s = 0 := by
      by_contra h
      have hpos : 0 < mu.real s := lt_of_le_of_ne measureReal_nonneg (Ne.symm h)
      exact absurd hpow (ne_of_gt (Real.rpow_pos_of_pos hpos _))
    exact (measureReal_eq_zero_iff (measure_ne_top mu s)).mp hms
  have hnull : mu {x | ¬ ‖symbol S x‖ ≤ c} = 0 := by
    have hsub : {x | ¬ ‖symbol S x‖ ≤ c}
        ⊆ ⋃ n : ℕ, ⋃ m : ℕ,
          {x | c + 1 / (n + 1 : ℝ) ≤ ‖symbol S x‖ ∧ ‖symbol S x‖ ≤ (m : ℝ)} := by
      intro x hx
      simp only [Set.mem_setOf_eq, not_le] at hx
      obtain ⟨n, hn⟩ := exists_nat_one_div_lt (sub_pos.mpr hx)
      obtain ⟨m, hm⟩ := exists_nat_ge ‖symbol S x‖
      exact Set.mem_iUnion.mpr ⟨n, Set.mem_iUnion.mpr ⟨m,
        ⟨by linarith, hm⟩⟩⟩
    refine measure_mono_null hsub (measure_iUnion_null fun n => measure_iUnion_null fun m => ?_)
    exact key n m
  simpa [ae_iff] using hnull
