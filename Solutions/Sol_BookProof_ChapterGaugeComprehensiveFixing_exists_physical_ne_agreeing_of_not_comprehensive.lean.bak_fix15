-- Generated from ChapterGaugeComprehensiveFixing.lean — solution of BookProof.ChapterGaugeComprehensiveFixing.exists_physical_ne_agreeing_of_not_comprehensive
import Mathlib
import Definitions.Def_ChapterGaugeComprehensiveFixing
open BookProof.ChapterGaugeComprehensiveFixing




open BookProof.ChapterGaugeIncompleteFixing

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]
variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}
variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution
    (hS : ¬ IsComprehensiveGaugeFixing G S) :
    ∃ f f' : X → ℝ, IsPhysicalObservable G f ∧ IsPhysicalObservable G f' ∧
      (∀ s ∈ S, f s = f' s) ∧ f ≠ f' := by

  classical
  rw [IsComprehensiveGaugeFixing] at hS
  push_neg at hS
  obtain ⟨x₀, hx₀⟩ := hS
  have horb : ∀ (y : X) (g : G), y ∈ MulAction.orbit G x₀ →
      g • y ∈ MulAction.orbit G x₀ := by
    intro y g hy
    rw [MulAction.mem_orbit_iff] at hy ⊢
    obtain ⟨k, hk⟩ := hy
    exact ⟨g * k, by rw [mul_smul, hk]⟩
  refine ⟨(MulAction.orbit G x₀).indicator (fun _ => (1 : ℝ)), 0, ?_, fun _ _ => rfl, ?_, ?_⟩
  · intro g x
    by_cases hx : x ∈ MulAction.orbit G x₀
    · rw [Set.indicator_of_mem hx, Set.indicator_of_mem (horb x g hx)]
    · rw [Set.indicator_of_notMem hx, Set.indicator_of_notMem]
      intro hmem
      have hback := horb _ g⁻¹ hmem
      rw [inv_smul_smul] at hback
      exact hx hback
  · intro s hsS
    have hns : s ∉ MulAction.orbit G x₀ := by
      intro hmem
      rw [MulAction.mem_orbit_iff] at hmem
      obtain ⟨k, hk⟩ := hmem
      exact hx₀ s hsS k⁻¹ (by rw [← hk, inv_smul_smul])
    simp [Set.indicator_of_notMem hns]
  · intro hcontra
    have h₀ : (MulAction.orbit G x₀).indicator (fun _ => (1 : ℝ)) x₀ = 0 := by
      rw [hcontra]; rfl
    rw [Set.indicator_of_mem (MulAction.mem_orbit_self x₀)] at h₀
    exact one_ne_zero h₀
