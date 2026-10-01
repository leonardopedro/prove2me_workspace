-- Generated from ChapterSirkTrotterKatoGalerkin.lean — theorem BookProof.ChapterSirkTrotterKato.flow_transfer_of_strong_tendsto
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterSirkTrotterKato

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport


theorem BookProof.ChapterSirkTrotterKato.flow_transfer_of_strong_tendsto {A : ℕ → H →L[ℂ] H} {Alim : H →L[ℂ] H}
    (hA : ∀ n, IsSelfAdjoint (A n)) (hlim : IsSelfAdjoint Alim)
    (hconv : ∀ u : H, Tendsto (fun n => A n u) atTop (𝓝 (Alim u))) (v : H)
    {T₀ : ℝ} (hT₀ : 0 ≤ T₀) :
    TendstoUniformlyOn (fun n t => (ofBounded (A n) (hA n)).stoneU t v)
      (fun t => (ofBounded Alim hlim).stoneU t v) atTop (Set.Icc (-T₀) T₀) := by sorry
