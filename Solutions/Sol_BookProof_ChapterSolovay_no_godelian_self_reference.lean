-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.no_godelian_self_reference
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] [NeZero N] :
    ¬ ∃ (Ψ : SolovayHilbertSpace N headDist),
    (∀ (φ : _root_.InnerSpace N → Prop), (φ = (fun _ => True)) ↔ (Ψ = toSolovay N headDist 0)) := by

  intro h
  rcases h with ⟨Ψ, hΨ⟩
  -- Take φ = const True. The biconditional gives Ψ = toSolovay N headDist 0.
  have h_const_true : (fun (_ : _root_.InnerSpace N) => True) = (fun _ => True) := rfl
  have h_psi_eq_zero : Ψ = toSolovay N headDist 0 :=
    ((hΨ (fun (_ : _root_.InnerSpace N) => True)).mp h_const_true)
  -- Now take φ(z) = (z.1 = 0), which is not constantly true since N > 0.
  let zeroHead : Fin N → ℝ := fun _ => 0
  let φ : _root_.InnerSpace N → Prop := fun z => (z.1 = zeroHead)
  have h_phi_not_const : φ ≠ (fun _ => True) := by
    intro h_eq
    -- Pick a nonzero element of Fin N → ℝ (exists because NeZero N)
    have hNpos : 0 < N := NeZero.pos N
    let nonzero : Fin N → ℝ := fun i => if i = ⟨0, hNpos⟩ then 1 else 0
    have h_nonzero_ne_zero : nonzero ≠ zeroHead := by
      intro hzero
      have := congr_fun hzero ⟨0, hNpos⟩
      simp [nonzero, zeroHead] at this
    have h_eq_at_nonzero : φ (nonzero, 0) = (fun _ => True) (nonzero, 0) := by rw [h_eq]
    unfold φ nonzero at h_eq_at_nonzero
    exact h_nonzero_ne_zero (h_eq_at_nonzero ▸ trivial)
  -- The biconditional for this φ gives a contradiction.
  have h_iff := hΨ φ
  -- h_iff : (φ = (fun _ => True)) ↔ (Ψ = toSolovay N headDist 0)
  have h_phi_eq_const : φ = (fun _ => True) := h_iff.mpr h_psi_eq_zero
  exact h_phi_not_const h_phi_eq_const
