-- Generated from ChapterEsaClosure.lean — theorem BookProof.EsaClosure.positiveExtension_eq_closure_of_esa
import Mathlib
import Definitions.Def_ChapterEsaClosure
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterSirkBandLedger
open BookProof.EsaClosure



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
