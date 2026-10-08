-- Generated from ChapterEsaClosure.lean — theorem BookProof.EsaClosure.positiveExtension_eq_closure_of_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterEsaClosure
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.YangMillsFriedrichs


open Filter Topology


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable [CompleteSpace F]

theorem BookProof.EsaClosure.positiveExtension_eq_closure_of_esa {Dom : Submodule ℂ F} {T : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (hesa : EssentiallySelfAdjointOn D T) (hA : IsPositiveSelfAdjointExtension T A) :
    Dom = clDom T ∧ ∀ (x : F) (h : x ∈ Dom) (h' : x ∈ clDom T),
      A ⟨x, h⟩ = clExt T hdense hsym ⟨x, h'⟩ := by sorry
