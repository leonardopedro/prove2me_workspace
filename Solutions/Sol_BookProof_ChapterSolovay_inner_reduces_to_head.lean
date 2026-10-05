-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.inner_reduces_to_head
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ₁ Ψ₂ : _root_.OuterWaveFunction N headDist)
    (hcyl₁ : _root_.dependsOnlyOnHead (Ψ₁ : _root_.InnerSpace N → ℂ))
    (hcyl₂ : _root_.dependsOnlyOnHead (Ψ₂ : _root_.InnerSpace N → ℂ)) :
    inner ℂ Ψ₁ Ψ₂ = ∫ x : _root_.InnerHead N, star (Ψ₁ (x, 0)) * (Ψ₂ (x, 0)) ∂headDist := by

  rcases hcyl₁ with ⟨g₁', hg₁⟩
  rcases hcyl₂ with ⟨g₂', hg₂⟩
  have h_tail_ne_zero : _root_.tailMeasure ≠ 0 := by
    have h_univ_one : _root_.tailMeasure Set.univ = 1 := measure_univ
    intro h_eq
    have h_univ_zero : _root_.tailMeasure Set.univ = 0 := by simp [h_eq]
    have h_eq_one_zero : (1 : ENNReal) = 0 := by
      rw [← h_univ_one, h_univ_zero]
    norm_num at h_eq_one_zero
  have h_map_fst : Measure.map Prod.fst (headDist.prod _root_.tailMeasure) = headDist := by
    rw [MeasureTheory.Measure.map_fst_prod, measure_univ, one_smul]
  have h_ae₁ : AEStronglyMeasurable (Ψ₁ : _root_.InnerSpace N → ℂ)
      (headDist.prod _root_.tailMeasure) :=
    Lp.aestronglyMeasurable _
  have h_ae₂ : AEStronglyMeasurable (Ψ₂ : _root_.InnerSpace N → ℂ)
      (headDist.prod _root_.tailMeasure) :=
    Lp.aestronglyMeasurable _
  have h_ae_comp₁ : AEStronglyMeasurable (g₁' ∘ Prod.fst) (headDist.prod _root_.tailMeasure) := by
    rw [← hg₁]; exact h_ae₁
  have h_ae_comp₂ : AEStronglyMeasurable (g₂' ∘ Prod.fst) (headDist.prod _root_.tailMeasure) := by
    rw [← hg₂]; exact h_ae₂
  have h_ae_g₁ : AEStronglyMeasurable g₁' headDist :=
    h_ae_comp₁.of_comp_fst h_tail_ne_zero
  have h_ae_g₂ : AEStronglyMeasurable g₂' headDist :=
    h_ae_comp₂.of_comp_fst h_tail_ne_zero
  have h_mem_comp₁ : MemLp (g₁' ∘ Prod.fst) 2 (headDist.prod _root_.tailMeasure) := by
    rw [← hg₁]; exact Lp.memLp _
  have h_mem_comp₂ : MemLp (g₂' ∘ Prod.fst) 2 (headDist.prod _root_.tailMeasure) := by
    rw [← hg₂]; exact Lp.memLp _
  have h_mem_g₁ : MemLp g₁' 2 headDist := by
    have h_ae_map : AEStronglyMeasurable g₁' (Measure.map Prod.fst
        (headDist.prod _root_.tailMeasure)) := by
      rw [h_map_fst]; exact h_ae_g₁
    have h_meas_fst : AEMeasurable Prod.fst
        (headDist.prod _root_.tailMeasure) :=
      measurable_fst.aemeasurable
    have h_equiv := MeasureTheory.memLp_map_measure_iff (p := 2) h_ae_map h_meas_fst
    rw [h_map_fst] at h_equiv
    exact h_equiv.mpr h_mem_comp₁
  have h_mem_g₂ : MemLp g₂' 2 headDist := by
    have h_ae_map : AEStronglyMeasurable g₂' (Measure.map Prod.fst
        (headDist.prod _root_.tailMeasure)) := by
      rw [h_map_fst]; exact h_ae_g₂
    have h_meas_fst : AEMeasurable Prod.fst
        (headDist.prod _root_.tailMeasure) :=
      measurable_fst.aemeasurable
    have h_equiv := MeasureTheory.memLp_map_measure_iff (p := 2) h_ae_map h_meas_fst
    rw [h_map_fst] at h_equiv
    exact h_equiv.mpr h_mem_comp₂
  let g₁ : Lp ℂ 2 headDist := h_mem_g₂.toLp g₂'
  let g₂ : Lp ℂ 2 headDist := h_mem_g₁.toLp g₁'
  have h_inner_eq : inner ℂ Ψ₁ Ψ₂ = ∫ z : _root_.InnerSpace N,
      (g₂' z.1) * star (g₁' z.1) ∂(headDist.prod _root_.tailMeasure) := by
    rw [MeasureTheory.L2.inner_def (𝕜 := ℂ) Ψ₁ Ψ₂]
    simp_rw [RCLike.inner_apply]
    refine integral_congr_ae ?_
    filter_upwards with z
    simp [hg₁, hg₂]
  have h_fubini_eq : ∫ z : _root_.InnerSpace N,
      (g₂' z.1) * star (g₁' z.1) ∂(headDist.prod _root_.tailMeasure) =
      ∫ x, (g₂' x) * star (g₁' x) ∂headDist := by
    have h_int_comp : Integrable (fun z : _root_.InnerSpace N => (g₂' z.1) * star (g₁' z.1))
        (headDist.prod _root_.tailMeasure) := by
      have h_int_inner : Integrable (fun z : _root_.InnerSpace N =>
          ((Ψ₂ : _root_.InnerSpace N → ℂ) z) * star ((Ψ₁ : _root_.InnerSpace N → ℂ) z))
          (headDist.prod _root_.tailMeasure) := by
        have h := MeasureTheory.L2.integrable_inner (𝕜 := ℂ) Ψ₁ Ψ₂
        simpa [RCLike.inner_apply, _root_.stateMeasure] using h
      have h_eq : (fun z : _root_.InnerSpace N => (g₂' z.1) * star (g₁' z.1))
          =ᵐ[headDist.prod _root_.tailMeasure]
          (fun z =>
            ((Ψ₂ : _root_.InnerSpace N → ℂ) z) * star ((Ψ₁ : _root_.InnerSpace N → ℂ) z)) := by
        filter_upwards with z
        simp [hg₁, hg₂]
      exact (integrable_congr h_eq).mpr h_int_inner
    have h_fubini : ∫ z : _root_.InnerSpace N,
        (g₂' z.1) * star (g₁' z.1) ∂(headDist.prod _root_.tailMeasure) =
        ∫ y, ∫ x, (g₂' x) * star (g₁' x) ∂headDist ∂_root_.tailMeasure := by
      exact integral_prod_symm
        (fun z : _root_.InnerHead N × _root_.InnerTail => (g₂' z.1) * star (g₁' z.1)) h_int_comp
    rw [h_fubini]
    simp [integral_const]
  have h_g_eq : ∫ x, (g₂' x) * star (g₁' x) ∂headDist = ∫ x, g₁ x * star (g₂ x) ∂headDist := by
    dsimp [g₁, g₂]
    refine integral_congr_ae ?_
    filter_upwards [MemLp.coeFn_toLp h_mem_g₂, MemLp.coeFn_toLp h_mem_g₁] with x h₂ h₁
    simp [h₂, h₁]
  calc
    inner ℂ Ψ₁ Ψ₂ = ∫ x, g₁ x * star (g₂ x) ∂headDist := by
      rw [h_inner_eq, h_fubini_eq, h_g_eq]
    _ = ∫ x, (g₂' x) * star (g₁' x) ∂headDist := by rw [h_g_eq]
    _ = ∫ x, star (g₁' x) * g₂' x ∂headDist := by
      refine integral_congr_ae ?_
      filter_upwards with x
      ring
    _ = ∫ x : _root_.InnerHead N, star (Ψ₁ (x, 0)) * (Ψ₂ (x, 0)) ∂headDist := by
      simp [hg₁, hg₂]
