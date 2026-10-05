-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.linearMap_ext_of_span
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa

variable {d : ℕ}



open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent


theorem BookProof.QuadratureEsa.linearMap_ext_of_span {E M ι : Type*} [AddCommGroup E] [Module ℂ E]
    [AddCommGroup M] [Module ℂ M] (v : ι → E) {D : Submodule ℂ E}
    (hD : Submodule.span ℂ (Set.range v) = D) (hvD : ∀ i, v i ∈ D)
    (F G : D →ₗ[ℂ] M) (h : ∀ i, F ⟨v i, hvD i⟩ = G ⟨v i, hvD i⟩) : F = G := by sorry
