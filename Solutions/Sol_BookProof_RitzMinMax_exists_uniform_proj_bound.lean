-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.exists_uniform_proj_bound
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (S : Submodule ℂ F)
    [FiniteDimensional ℂ S] {ε : ℝ} (hε : 0 < ε) :
    ∃ m₀ : ℕ, ∀ m ≥ m₀, ∀ x ∈ S,
      ‖(galerkinSpan b m).starProjection x - x‖ ≤ ε * ‖x‖ := by

  classical
  set d := Module.finrank ℂ S with hd
  set e := stdOrthonormalBasis ℂ S with he
  set g : ℕ → (F →L[ℂ] F) :=
    fun m => (galerkinSpan b m).starProjection - ContinuousLinearMap.id ℂ F with hg
  have hgapp : ∀ (m : ℕ) (x : F), g m x = (galerkinSpan b m).starProjection x - x := by
    intro m x
    simp [hg]
  have htend : ∀ i : Fin d, ∀ᶠ m : ℕ in atTop, ‖g m ((e i : S) : F)‖ ≤ ε / (d + 1) := by
    intro i
    have h := galerkinProj_tendsto b ((e i : S) : F)
    rw [tendsto_iff_norm_sub_tendsto_zero] at h
    have hpos : 0 < ε / (d + 1) := by positivity
    have h2 := h.eventually (eventually_le_nhds hpos)
    filter_upwards [h2] with m hm
    rw [hgapp]
    exact hm
  have hall : ∀ᶠ m : ℕ in atTop, ∀ i : Fin d, ‖g m ((e i : S) : F)‖ ≤ ε / (d + 1) :=
    eventually_all.2 htend
  obtain ⟨m₀, hm₀⟩ := eventually_atTop.mp hall
  refine ⟨m₀, fun m hm x hx => ?_⟩
  have hbound := hm₀ m hm
  set y : S := ⟨x, hx⟩ with hy
  have hxsum : x = ∑ i : Fin d, (e.repr y i) • ((e i : S) : F) := by
    have h1 := e.sum_repr y
    have h2 := congrArg (fun z : S => (z : F)) h1
    simpa using h2.symm
  have hgx : g m x = ∑ i : Fin d, (e.repr y i) • (g m ((e i : S) : F)) := by
    rw [hxsum]
    simp [map_sum]
  have hcoef : ∀ i : Fin d, ‖e.repr y i‖ ≤ ‖x‖ := by
    intro i
    rw [e.repr_apply_apply]
    calc ‖(inner ℂ (e i) y : ℂ)‖ ≤ ‖(e i : S)‖ * ‖y‖ := norm_inner_le_norm _ _
      _ = ‖x‖ := by rw [e.orthonormal.1 i]; simp [hy]
  have hdd : (d : ℝ) / (d + 1) ≤ 1 := by
    rw [div_le_one (by positivity)]
    linarith
  calc ‖(galerkinSpan b m).starProjection x - x‖ = ‖g m x‖ := by rw [hgapp]
    _ = ‖∑ i : Fin d, (e.repr y i) • (g m ((e i : S) : F))‖ := by rw [hgx]
    _ ≤ ∑ i : Fin d, ‖(e.repr y i) • (g m ((e i : S) : F))‖ := norm_sum_le _ _
    _ ≤ ∑ _i : Fin d, ‖x‖ * (ε / (d + 1)) := by
        refine Finset.sum_le_sum fun i _ => ?_
        rw [norm_smul]
        exact mul_le_mul (hcoef i) (hbound i) (norm_nonneg _) (norm_nonneg _)
    _ = (d : ℝ) * (‖x‖ * (ε / (d + 1))) := by simp [Finset.sum_const]
    _ = ((d : ℝ) / (d + 1)) * (ε * ‖x‖) := by field_simp
    _ ≤ 1 * (ε * ‖x‖) := mul_le_mul_of_nonneg_right hdd (by positivity)
    _ = ε * ‖x‖ := one_mul _
