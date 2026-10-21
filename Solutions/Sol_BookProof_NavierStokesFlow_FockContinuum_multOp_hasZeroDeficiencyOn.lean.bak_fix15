-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.multOp_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_memLp_conj
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    HasZeroDeficiencyOn (boundedEnergyCore μ g) (multOp μ hg) :=
  re has *no* eigenvectors in general
  — its spectrum is the essential range of `g`, typically an interval — and it is
  unbounded whenever `g` is. -/
  theorem multOp_hasZeroDeficiencyOn (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
      HasZeroDeficiencyOn (boundedEnergyCore μ g) (multOp μ hg) := by
    have key : ∀ c : ℂ, c.im ≠ 0 → ∀ w : Lp ℂ 2 μ,
        (∀ v : boundedEnergyCore μ g,
          (inner ℂ ((multOp μ hg v : boundedEnergyCore μ g) : Lp ℂ 2 μ) w : ℂ)
            = inner ℂ ((v : boundedEnergyCore μ g) : Lp ℂ 2 μ) (c • w)) → w = 0 := by
      intro c hc w hw
      set W : X → ℂ := fun x => ((g x : ℂ) - c) * ((w : X → ℂ) x) with hW
      have hmeasW : AEStronglyMeasurable W μ :=
        ((Complex.measurable_ofReal.comp hg).aestronglyMeasurable.sub
          aestronglyMeasurable_const).mul (Lp.aestronglyMeasurable w)
      have hzero : ∀ n : ℕ, ∀ᵐ x ∂μ, |g x| ≤ (n : ℝ) → W x = 0 := by
        intro n
        have hmeasS : MeasurableSet {x | |g x| ≤ (n : ℝ)} :=
          measurableSet_le hg.abs measurable_const
        set u : X → ℂ := Set.indicator {x | |g x| ≤ (n : ℝ)} W with hu
        have hmeasu : AEStronglyMeasurable u μ := hmeasW.indicator hmeasS
        have hbound : ∀ᵐ x ∂μ, ‖u x‖ ≤ ((n : ℝ) + ‖c‖) * ‖(w : X → ℂ) x‖ := by
          filter_upwards with x
          by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
          · have hgc : ‖((g x : ℂ) - c)‖ ≤ (n : ℝ) + ‖c‖ := by
              refine le_trans (norm_sub_le _ _) ?_
              have h1 : ‖((g x : ℂ))‖ ≤ (n : ℝ) := by
                rw [Complex.norm_real, Real.norm_eq_abs]; exact h
              linarith
            rw [hu, Set.indicator_of_mem h, hW, norm_mul]
            exact mul_le_mul_of_nonneg_right hgc (norm_nonneg _)
          · rw [hu, Set.indicator_of_notMem h, norm_zero]
            positivity
        have humem : MemLp u 2 μ := MemLp.of_le_mul (Lp.memLp w) hmeasu hbound
        have hucore : humem.toLp u ∈ boundedEnergyCore μ g := by
          refine ⟨n, ?_⟩
          filter_upwards [humem.coeFn_toLp] with x hx hbig
          rw [hx, hu, Set.indicator_of_notMem (by simpa using hbig)]
        have hid := hw ⟨humem.toLp u, hucore⟩
        have hleft : (inner ℂ ((multOp μ hg ⟨humem.toLp u, hucore⟩ : boundedEnergyCore μ g) :
            Lp ℂ 2 μ) w : ℂ)
            = ∫ x, (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x ∂μ := by
          rw [L2.inner_def]
          refine integral_congr_ae ?_
          filter_upwards [multOp_coeFn μ hg ⟨humem.toLp u, hucore⟩, humem.coeFn_toLp] with x h1 h2
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
          have hintegrand : ∀ x, (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x
              - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)
              = ((‖u x‖ ^ 2 : ℝ) : ℂ) := by
            intro x
            by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
            · have hux : u x = ((g x : ℂ) - c) * ((w : X → ℂ) x) := by
                rw [hu, Set.indicator_of_mem h]
              have hconj : (starRingEnd ℂ) (u x) * u x = ((‖u x‖ ^ 2 : ℝ) : ℂ) := by
                have hmc := Complex.mul_conj' (u x)
                push_cast
                linear_combination hmc
              calc (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x
                    - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)
                  = (starRingEnd ℂ) (u x) * (((g x : ℂ) - c) * (w : X → ℂ) x) := by
                    simp only [map_mul, Complex.conj_ofReal]
                    ring
                _ = (starRingEnd ℂ) (u x) * u x := by rw [hux]
                _ = ((‖u x‖ ^ 2 : ℝ) : ℂ) := hconj
            · rw [hu, Set.indicator_of_notMem h]
              simp
          have hzeroint : ∫ x, (((‖u x‖ ^ 2 : ℝ)) : ℂ) ∂μ = 0 := by
            have hint1 : Integrable
                (fun x => (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x) μ := by
              have h1 : MemLp (fun x => (g x : ℂ) * u x) 2 μ := by
                have hb : ∀ᵐ x ∂μ, ‖(g x : ℂ) * u x‖ ≤ (n : ℝ) * ‖u x‖ := by
                  filter_upwards with x
                  by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
                  · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
                    exact mul_le_mul_of_nonneg_right h (norm_nonneg _)
                  · rw [hu, Set.indicator_of_notMem h]
                    simp
                exact MemLp.of_le_mul humem
                  ((Complex.measurable_ofReal.comp hg).aestronglyMeasurable.mul hmeasu) hb
              exact MemLp.integrable_mul (memLp_conj h1) (Lp.memLp w)
            have hint2 : Integrable
                (fun x => (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)) μ := by
              exact MemLp.integrable_mul (memLp_conj humem) ((Lp.memLp w).const_mul c)
            have hsub : ∫ x, ((starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x
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
      have hne : ((g x : ℂ) - c) ≠ 0 := by
        intro h
        have him := congrArg Complex.im h
        simp only [Complex.sub_im, Complex.ofRe
