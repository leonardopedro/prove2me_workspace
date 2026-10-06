-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clExt_selfAdjointCriterion
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.clExt_selfAdjointCriterion (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) (w u : F)
    (hw : ∀ v : clDom T, (inner ℂ (clExt T hdense hsym v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ clDom T, clExt T hdense hsym ⟨w, h⟩ = u := by sorry
