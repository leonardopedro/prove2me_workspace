-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.exists_source_of_isRealSystemIso
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {N : System ℂ W}
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) {n : W →L[ℂ] W} (hn : n ∈ N.ops) :
    ∃ m ∈ M.ops, ∀ w, n w = β (m (β.symm w)) := by

  have hmem : (n.restrictScalars ℝ) ∈
      (fun m : V →L[ℂ] V => conjClmR β (m.restrictScalars ℝ)) '' M.ops := by
    rw [← hβ]; exact ⟨n, hn, rfl⟩
  obtain ⟨m, hm, hmeq⟩ := hmem
  refine ⟨m, hm, fun w => ?_⟩
  have := congr_arg (fun T : W →L[ℝ] W => T w) hmeq
  simpa [conjClmR_apply] using this.symm
