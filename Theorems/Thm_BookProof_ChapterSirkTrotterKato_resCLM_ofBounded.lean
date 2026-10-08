-- Generated from ChapterSirkTrotterKatoGalerkin.lean — theorem BookProof.ChapterSirkTrotterKato.resCLM_ofBounded
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato


noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


theorem BookProof.ChapterSirkTrotterKato.resCLM_ofBounded (A : H →L[ℂ] H) (hA : IsSelfAdjoint A) (y : H) :
    (ofBounded A hA).resCLM 1 y = -(resolvent A Complex.I y) := by sorry
