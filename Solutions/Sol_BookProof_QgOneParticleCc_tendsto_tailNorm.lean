-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.tendsto_tailNorm
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {g : Vd d → ℝ} (hg : MemLp g 2 (volume : Measure (Vd d))) :
    Filter.Tendsto
      (fun n : ℕ => (eLpNorm (({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) 2
        (volume : Measure (Vd d))).toReal) Filter.atTop (nhds 0) := by

  set μ : Measure (Vd d) := volume with hμ
  have hmeasS : ∀ n : ℕ, MeasurableSet ({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ) :=
    fun n => (measurableSet_le (by fun_prop) measurable_const).compl
  have hrw : ∀ n : ℕ, eLpNorm (({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) 2 μ
      = (∫⁻ z, ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ) ∂μ) ^ (1 / (2 : ℝ)) := by
    intro n
    rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num),
      show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num]
  have hlim : Filter.Tendsto
      (fun n : ℕ => ∫⁻ z, ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ) ∂μ)
      Filter.atTop (nhds 0) := by
    have hdom : ∀ n : ℕ,
        (fun z => ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ))
          ≤ᵐ[μ] fun z => ‖g z‖ₑ ^ (2 : ℝ) := by
      intro n
      filter_upwards with z
      by_cases h : z ∈ ({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ)
      · rw [Set.indicator_of_mem h]
      · rw [Set.indicator_of_notMem h]; simp
    have hbdd : ∫⁻ z, ‖g z‖ₑ ^ (2 : ℝ) ∂μ ≠ ⊤ := by
      intro hcon
      have h := hg.2
      rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num)] at h
      rw [show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num, hcon] at h
      simp [ENNReal.top_rpow_of_pos] at h
    have hae : ∀ᵐ z ∂μ, Filter.Tendsto
        (fun n : ℕ => ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ))
        Filter.atTop (nhds 0) := by
      filter_upwards with z
      obtain ⟨N, hN⟩ := exists_nat_ge ‖z‖
      refine Filter.Tendsto.congr' ?_ tendsto_const_nhds (f₁ := fun _ : ℕ => (0 : ENNReal))
      filter_upwards [Filter.eventually_ge_atTop N] with n hn
      have hz : z ∈ {z : Vd d | ‖z‖ ≤ (n : ℝ)} := le_trans hN (by exact_mod_cast hn)
      rw [Set.indicator_of_notMem (by simpa using hz)]
      simp
    have hdct := tendsto_lintegral_of_dominated_convergence' (μ := μ) (f := fun _ => (0 : ENNReal))
      (fun z => ‖g z‖ₑ ^ (2 : ℝ))
      (fun n => ((hg.1.indicator (hmeasS n)).enorm).pow_const _)
      hdom hbdd hae
    simpa using hdct
  have h2 : Filter.Tendsto
      (fun n : ℕ => eLpNorm (({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) 2 μ)
      Filter.atTop (nhds 0) := by
    have heq : (fun n : ℕ => eLpNorm (({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) 2 μ)
      = fun n : ℕ =>
          (∫⁻ z, ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ) ∂μ) ^ (1 / (2 : ℝ)) := by
      funext n
      exact hrw n
    have hlim' : Filter.Tendsto
        (fun n : ℕ => (∫⁻ z, ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ) ∂μ)
          ^ (1 / (2 : ℝ)))
        Filter.atTop (nhds 0) := by
      have h := ((ENNReal.continuous_rpow_const (y := (1 / 2 : ℝ))).tendsto 0).comp hlim
      show Filter.Tendsto
          ((fun a : ENNReal => a ^ (1 / 2)) ∘ fun n : ℕ =>
            ∫⁻ z, ‖(({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) z‖ₑ ^ (2 : ℝ) ∂μ)
          Filter.atTop (nhds 0)
      simpa using h
    rw [heq]
    exact hlim'
  have ht2 : Filter.Tendsto ENNReal.toReal (nhds 0) (nhds 0) :=
    ENNReal.tendsto_toReal (by simp)
  have h3 := ht2.comp h2
  show Filter.Tendsto
      (ENNReal.toReal ∘ fun n : ℕ => eLpNorm (({z : Vd d | ‖z‖ ≤ (n : ℝ)}ᶜ).indicator g) 2 μ)
      Filter.atTop (nhds 0)
  simpa using h3
