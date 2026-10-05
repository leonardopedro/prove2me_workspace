-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.mulD_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g h : X → ℝ} (hg : Measurable g)
    (hh : Measurable h) (hdom : DominatedOn μ g h) :
    HasZeroDeficiencyOn (boundedEnergyCore μ g) (mulD μ hh hdom) := by

  have key : ∀ c : ℂ, c.im ≠ 0 → ∀ w : Lp ℂ 2 μ,
      (∀ v : boundedEnergyCore μ g,
        (inner ℂ ((mulD μ hh hdom v : boundedEnergyCore μ g) : Lp ℂ 2 μ) w : ℂ)
          = inner ℂ ((v : boundedEnergyCore μ g) : Lp ℂ 2 μ) (c • w)) → w = 0 := by
    intro c hc w hw
    set W : X → ℂ := fun x => ((h x : ℂ) - c) * ((w : X → ℂ) x) with hW
    have hmeasW : AEStronglyMeasurable W μ :=
      ((Complex.measurable_ofReal.comp hh).aestronglyMeasurable.sub
        aestronglyMeasurable_const).mul (Lp.aestronglyMeasurable w)
    have hzero : ∀ n : ℕ, ∀ᵐ x ∂μ, |g x| ≤ (n : ℝ) → W x = 0 := by
      intro n
      obtain ⟨M, hM, hMx⟩ := hdom n
      have hmeasS : MeasurableSet {x | |g x| ≤ (n : ℝ)} :=
        measurableSet_le hg.abs measurable_const
      set u : X → ℂ := Set.indicator {x | |g x| ≤ (n : ℝ)} W with hu
      have hmeasu : AEStronglyMeasurable u μ := hmeasW.indicator hmeasS
      have hbound : ∀ᵐ x ∂μ, ‖u x‖ ≤ (M + ‖c‖) * ‖(w : X → ℂ) x‖ := by
        filter_upwards [hMx] with x hMb
        by_cases hx : x ∈ {x | |g x| ≤ (n : ℝ)}
        · have hgc : ‖((h x : ℂ) - c)‖ ≤ M + ‖c‖ := by
            refine le_trans (norm_sub_le _ _) ?_
            have h1 : ‖((h x : ℂ))‖ ≤ M := by
              rw [Complex.norm_real, Real.norm_eq_abs]; exact hMb hx
            linarith
          rw [hu, Set.indicator_of_mem hx, hW, norm_mul]
          exact mul_le_mul_of_nonneg_right hgc (norm_nonneg _)
        · rw [hu, Set.indicator_of_notMem hx, norm_zero]
          have : (0 : ℝ) ≤ M + ‖c‖ := by positivity
          positivity
      have humem : MemLp u 2 μ := MemLp.of_le_mul (Lp.memLp w) hmeasu hbound
      have hucore : humem.toLp u ∈ boundedEnergyCore μ g := by
        refine ⟨n, ?_⟩
        filter_upwards [humem.coeFn_toLp] with x hx hbig
        rw [hx, hu, Set.indicator_of_notMem (by simpa using hbig)]
      have hid := hw ⟨humem.toLp u, hucore⟩
      have hleft : (inner ℂ ((mulD μ hh hdom ⟨humem.toLp u, hucore⟩ : boundedEnergyCore μ g) :
          Lp ℂ 2 μ) w : ℂ)
          = ∫ x, (starRingEnd ℂ) ((h x : ℂ) * u x) * (w : X → ℂ) x ∂μ := by
        rw [L2.inner_def]
        refine integral_congr_ae ?_
        filter_upwards [mulD_coeFn μ hh hdom ⟨humem.toLp u, hucore⟩, humem.coeFn_toLp]
          with x h1 h2
        simp only [RCLike.inner_apply, h1, h2]
        ring
      have hright : (inner ℂ ((⟨humem.toLp u, hucore⟩ : boundedEnergyCore μ g) : Lp ℂ 2 μ)
          (c • w) : ℂ) = ∫ x, (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x) ∂μ := by
        rw [L2.inner_def]
        refine integral_congr_ae ?_
        filter_upwards [humem.coeFn_toLp, Lp.coeFn_smul c w] with x h1 h2
        simp only [RCLike.inner_apply, h1, h2, Pi.smul_apply, smul_eq_mul]
        ring
      rw [hleft, hright] at hid
      have hcombine : ∫ x, ‖u x‖ ^ 2 ∂μ = 0 := by
        have hintegrand : ∀ x, (starRingEnd ℂ) ((h x : ℂ) * u x) * (w : X → ℂ) x
            - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)
            = ((‖u x‖ ^ 2 : ℝ) : ℂ) := by
          intro x
          by_cases hx : x ∈ {x | |g x| ≤ (n : ℝ)}
          · have hux : u x = ((h x : ℂ) - c) * ((w : X → ℂ) x) := by
              rw [hu, Set.indicator_of_mem hx]
            have hconj : (starRingEnd ℂ) (u x) * u x = ((‖u x‖ ^ 2 : ℝ) : ℂ) := by
              have hmc := Complex.mul_conj' (u x)
              push_cast
              linear_combination hmc
            calc (starRingEnd ℂ) ((h x : ℂ) * u x) * (w : X → ℂ) x
                  - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)
                = (starRingEnd ℂ) (u x) * (((h x : ℂ) - c) * (w : X → ℂ) x) := by
                  simp only [map_mul, Complex.conj_ofReal]
                  ring
              _ = (starRingEnd ℂ) (u x) * u x := by rw [hux]
              _ = ((‖u x‖ ^ 2 : ℝ) : ℂ) := hconj
          · rw [hu, Set.indicator_of_notMem hx]
            simp
        have hzeroint : ∫ x, (((‖u x‖ ^ 2 : ℝ)) : ℂ) ∂μ = 0 := by
          have hint1 : Integrable
              (fun x => (starRingEnd ℂ) ((h x : ℂ) * u x) * (w : X → ℂ) x) μ := by
            have h1 : MemLp (fun x => (h x : ℂ) * u x) 2 μ := by
              have hb : ∀ᵐ x ∂μ, ‖(h x : ℂ) * u x‖ ≤ M * ‖u x‖ := by
                filter_upwards [hMx] with x hMb
                by_cases hx : x ∈ {x | |g x| ≤ (n : ℝ)}
                · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
                  exact mul_le_mul_of_nonneg_right (hMb hx) (norm_nonneg _)
                · rw [hu, Set.indicator_of_notMem hx]
                  simp
              exact MemLp.of_le_mul humem
                ((Complex.measurable_ofReal.comp hh).aestronglyMeasurable.mul hmeasu) hb
            exact MemLp.integrable_mul (memLp_conj h1) (Lp.memLp w)
          have hint2 : Integrable
              (fun x => (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)) μ := by
            exact MemLp.integrable_mul (memLp_conj humem) ((Lp.memLp w).const_mul c)
          have hsub : ∫ x, ((starRingEnd ℂ) ((h x : ℂ) * u x) * (w : X → ℂ) x
              - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)) ∂μ = 0 := by
            rw [integral_sub hint1 hint2, ← hid, sub_self]
          rw [← hsub]
          exact integral_congr_ae (Filter.Eventually.of_forall fun x => (hintegrand x).symm)
        have hre := congrArg Complex.re hzeroint
        rw [integral_complex_ofReal] at hre
        simpa using hre
      have hnn : 0 ≤ fun x => ‖u x‖ ^ 2 := fun x => by positivity
      have hintu : Integrable (fun x => ‖u x‖ ^ 2) μ := by
        have := humem.integrable_norm_rpow (by norm_num) (by norm_num)
        simpa [Real.rpow_natCast] using this
      have hae := (integral_eq_zero_iff_of_nonneg hnn hintu).1 hcombine
      filter_upwards [hae] with x hx hbig
      have hu0 : u x = 0 := by
        have hnorm : ‖u x‖ ^ 2 = 0 := hx
        simpa [pow_eq_zero_iff] using hnorm
      rw [← hu0, hu, Set.indicator_of_mem (show x ∈ {x | |g x| ≤ (n : ℝ)} from hbig)]
    have hWzero : ∀ᵐ x ∂μ, W x = 0 := by
      have hall : ∀ᵐ x ∂μ, ∀ n : ℕ, |g x| ≤ (n : ℝ) → W x = 0 := ae_all_iff.2 hzero
      filter_upwards [hall] with x hx
      obtain ⟨n, hn⟩ := exists_nat_ge |g x|
      exact hx n hn
    refine Lp.ext ?_
    filter_upwards [hWzero, Lp.coeFn_zero (E := ℂ) (p := 2) (μ := μ)] with x hx hz
    rw [hz]
    have hne : ((h x : ℂ) - c) ≠ 0 := by
      intro hzc
      have him := congrArg Complex.im hzc
      simp only [Complex.sub_im, Complex.ofReal_im, zero_sub, Complex.zero_im,
        neg_eq_zero] at him
      exact hc him
    exact (mul_eq_zero.1 hx).resolve_left hne
  refine ⟨fun w hw => key Complex.I (by simp) w ?_, fun w hw => key (-Complex.I) (by simp) w ?_⟩
  · intro v; exact hw v
  · intro v; rw [neg_smul]; exact hw v
