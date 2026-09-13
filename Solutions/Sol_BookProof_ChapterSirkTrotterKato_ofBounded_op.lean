-- Generated from ChapterSirkTrotterKatoGalerkin.lean — solution of BookProof.ChapterSirkTrotterKato.ofBounded_op
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato









noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (A : H →L[ℂ] H) (hA : IsSelfAdjoint A) (x : H)
    (hx : x ∈ (ofBounded A hA).domain) : (ofBounded A hA).op ⟨x, hx⟩ = A x := rfl
