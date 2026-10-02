-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.boundedEnergyCore_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_tendsto_eLpNorm_indicator_compl
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
imp only [one_div] at h
  rw [show (0 : ENNReal) ^ (2 : ℝ)⁻¹ = 0 from ENNReal.zero_rpow_of_pos (by norm_num)] at h
  have hfun : ∀ I : ℕ → ENNReal,
      (fun a : ENNReal => a ^ (2:ℝ)⁻¹) ∘ I = fun n => I n ^ (2:ℝ)⁻¹ := fun I => rfl
  simp only [one_div]
  rw [← hfun]
  exact h

/-- **The bounded-energy core is dense.**  Every square-integrable state is the
`L²`-limit of its :=
  truncations to the regions where the energy is bounded, so the
  core is a genuine dense domain for the multiplication operator. -/
  theorem boundedEnergyCore_dense (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
      Dense ((boundedEnergyCore μ g : Submodule ℂ (Lp ℂ 2 μ)) : Set (Lp ℂ 2 μ)) := by
    have hmeasS : ∀ n : ℕ, MeasurableSet {x | |g x| ≤ (n : ℝ)} :=
      fun n => measurableSet_le hg.abs measurable_const
    intro f
    refine mem_closure_iff_seq_limit.2
      ⟨fun n => ((Lp.memLp f).indicator (hmeasS n)).toLp _, fun n => ?_, ?_⟩
    · refine ⟨n, ?_⟩
      filter_upwards [((Lp.memLp f).indicator (hmeasS n)).coeFn_toLp] with x hx hbig
      rw [hx, Set.indicator_of_notMem (by simpa using hbig)]
    · have heq : ∀ n : ℕ,
          eLpNorm ({x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)) 2 μ
            = eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator ((f : X → ℂ))) 2 μ := by
        intro n
        have hfun : {x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)
            = -({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) := by
          funext x
          by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
          · simp [Set.indicator_of_mem h,
              Set.indicator_of_notMem (show x ∉ {x | |g x| ≤ (n : ℝ)}ᶜ by simpa using h)]
          · simp [Set.indicator_of_notMem h,
              Set.indicator_of_mem (show x ∈ {x | |g x| ≤ (n : ℝ)}ᶜ from h)]
        rw [hfun, eLpNorm_neg]
      have hten : Filter.Tendsto
          (fun n : ℕ => eLpNorm ({x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)) 2 μ)
          Filter.atTop (nhds 0) := by
        simp
