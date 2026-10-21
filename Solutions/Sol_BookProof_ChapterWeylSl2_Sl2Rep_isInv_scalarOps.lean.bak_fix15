-- Generated from ChapterWeylSl2.lean — solution of BookProof.ChapterWeylSl2.Sl2Rep.isInv_scalarOps
import Mathlib
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2.Sl2Rep




universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

set_option maxHeartbeats 1000000 in
theorem solution {R : Sl2Rep V} {W : Submodule ℂ V} (hW : R.IsInv W) :
    (adRep R).IsInv (scalarOps W) := by

  have key : ∀ (a : Module.End ℂ V), (∀ x ∈ W, a x ∈ W) → ∀ f ∈ scalarOps W,
      (a * f - f * a) ∈ scalarOps W := by
    rintro a ha f ⟨hf1, c, hf2⟩
    refine ⟨fun v => ?_, 0, fun w hw => ?_⟩
    · simp only [Module.End.mul_apply, LinearMap.sub_apply]
      exact W.sub_mem (ha _ (hf1 v)) (hf1 _)
    · simp only [Module.End.mul_apply, LinearMap.sub_apply]
      rw [hf2 w hw, hf2 _ (ha w hw), map_smul, sub_self, zero_smul]
  exact ⟨fun f hf => by rw [adRep_E]; exact key R.E hW.1 f hf,
    fun f hf => by rw [adRep_F]; exact key R.F hW.2.1 f hf,
    fun f hf => by rw [adRep_H]; exact key R.H hW.2.2 f hf⟩
