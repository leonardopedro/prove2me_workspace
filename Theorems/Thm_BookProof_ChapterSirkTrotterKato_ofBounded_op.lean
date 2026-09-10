-- Generated from ChapterSirkTrotterKatoGalerkin.lean — theorem BookProof.ChapterSirkTrotterKato.ofBounded_op
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
open BookProof.ChapterSirkTrotterKato








noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterSirkTrotterKato.ofBounded_op (A : H →L[ℂ] H) (hA : IsSelfAdjoint A) (x : H)
    (hx : x ∈ (ofBounded A hA).domain) : (ofBounded A hA).op ⟨x, hx⟩ = A x := by sorry
