-- Generated from ChapterStoneEigenflow.lean — theorem BookProof.StoneEigenflow.isSelfAdjointExtension_eigenvector
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterStoneEigenflow
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.StoneEigenflow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge


theorem BookProof.StoneEigenflow.isSelfAdjointExtension_eigenvector {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (h : IsSelfAdjointExtension Hc A) (x : D) {lam : ℂ}
    (hx : Hc x = lam • (x : F)) :
    ∃ hmem : (x : F) ∈ Dom, A ⟨(x : F), hmem⟩ = lam • (x : F) := by sorry
