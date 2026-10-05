-- Generated from ChapterA1e.lean — solution of BookProof.ChapterA.sup_JY_Jinvariant
import Mathlib
import Definitions.Def_ChapterA1e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Submodule ℝ V) :
    ∀ x ∈ Y ⊔ JY Y, Jmap x ∈ Y ⊔ JY Y := by

  intro x hx;    rw [ Submodule.mem_sup ] at hx;    obtain ⟨ a, ha, b, hb, rfl ⟩ := hx;
  simp_all only [Jmap_apply, smul_add, Submodule.mem_sup] ;
  refine ⟨ Complex.I • b, ?_, Complex.I • a, ?_, ?_ ⟩ <;>
    simp_all only [JY, Submodule.mem_map, LinearIsometry.coe_toLinearMap,
      LinearIsometryEquiv.coe_toLinearIsometry, Jmap_apply, ne_eq, Complex.I_ne_zero,
      not_false_eq_true, smul_right_inj, exists_eq_right];
  · obtain ⟨ y, hy, rfl ⟩ := hb; simp [ ← smul_assoc, hy ] ;
  · exact add_comm _ _
