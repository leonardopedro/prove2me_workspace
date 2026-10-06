-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clShift_surjective
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_clRange_isClosed
import Theorems.Thm_BookProof_EsaClosure_clRange_orthogonal_eq_bot
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (hesa : EssentiallySelfAdjointOn D T) :
    Function.Surjective (cshiftMap (clExt T hdense hsym) Complex.I) :=
  xt T hdense hsym) Complex.I) := by
    have hclosed : IsClosed ((cshiftRange (clExt T hdense hsym) Complex.I : Submodule ℂ F) : Set F) :=
      clRange_isClosed T hdense hsym (by simp)
    have : CompleteSpace (cshiftRange (clExt T hdense hsym) Complex.I) := hclosed.completeSpace_coe
    have htop : cshiftRange (clExt T hdense hsym) Complex.I = ⊤ := by
      have h1 := Submodule.orthogonal_orthogonal (cshiftRange (clExt T hdense hsym) Complex.I)
      rw [clRange_orthogonal_eq_bot T hdense hsym hesa, Submodule.bot_orthogonal_eq_top] at h1
      exact h1.symm
    intro u
    have hmem : u ∈ cshiftRange (clExt T hdense hsym) Complex.I := by rw
