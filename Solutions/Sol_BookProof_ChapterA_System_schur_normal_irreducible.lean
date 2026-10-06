-- Generated from ChapterA.lean — solution of BookProof.ChapterA.System.schur_normal_irreducible
import Mathlib
import Definitions.Def_ChapterA
import Theorems.Thm_BookProof_ChapterA_System_orthogonal_isSubsystem
open BookProof.ChapterA
open BookProof.ChapterA.System



open scoped ComplexConjugate InnerProductSpace

variable {𝔽 : Type*} [RCLike 𝔽] {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace 𝔽 V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System 𝔽 V) (hM : IsNormal M)
    (hSchur : ∀ S : V →L[𝔽] V, M.Commutes S → IsSelfAdjoint S →
      ∃ c : 𝔽, S = c • (1 : V →L[𝔽] V)) :
    IsIrreducible M := by

  intro W hW
  obtain ⟨hW_subsystem, hW_closed⟩ := hW
  have hW_orthogonal : IsClosed (Wᗮ : Set V) ∧ ∀ m ∈ M.ops, ∀ w ∈ Wᗮ, m w ∈ Wᗮ := by
    have hsub := orthogonal_isSubsystem M hM ⟨hW_subsystem, hW_closed⟩
    exact hsub
  obtain ⟨c, hc⟩ := hSchur (W.starProjection) (by
  intro m hm;    ext v;    rw [mul_apply_eq_comp, mul_apply_eq_comp];  have
      h_decomp : m v = m (W.starProjection v) + m (v - W.starProjection v) := by
    rw [ ← map_add, add_sub_cancel ];
  have h_comm : W.starProjection (m (v - W.starProjection v)) = 0 := by
    have h_comm : m (v - W.starProjection v) ∈ Wᗮ := by
      exact hW_orthogonal.2 m hm _ ( Submodule.sub_starProjection_mem_orthogonal v );
    exact (Submodule.starProjection_apply_eq_zero_iff W).mpr h_comm
  rw [ h_decomp, map_add, h_comm, add_zero ];
  exact Submodule.starProjection_eq_self_iff.mpr ( hW_closed m hm _ ( Submodule.coe_mem _ ) )) (by
  grind +suggestions);
  by_cases hc0 : c = 0;
  · simp_all only [zero_smul, Submodule.eq_bot_iff];
    left;
    intro x hx;      replace hc := congr_arg ( fun f => f x ) hc;      simp_all  ;
    rw [ Submodule.starProjection_eq_self_iff.mpr hx ] at hc ; aesop;
  · have hW_top : ∀ v : V, v ∈ W := by
      intro v
      have hv : v = (c⁻¹ • W.starProjection) v := by
        simp [ hc, hc0 ];
      exact hv.symm ▸ Submodule.smul_mem _ _ ( Submodule.coe_mem _ );
    exact Or.inr ( eq_top_iff.mpr fun v _ => hW_top v )
