-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clExt_selfAdjointCriterion
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]
variable [CompleteSpace F] {Dom : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

top]; trivial
  exact hmem

theorem BookProof.EsaClosure.clExt_selfAdjointCriterion (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) (w u : F)
    (hw : ∀ v : clDom T, (inner ℂ (clExt T hdense hsym v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ clDom T, clExt T := by sorry
