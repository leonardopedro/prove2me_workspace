-- Generated from ChapterSirkTrotterKatoGalerkin.lean — theorem BookProof.ChapterSirkTrotterKato.galerkin_flow_transfer
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
open BookProof.ChapterSirkTrotterKato








noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]










open BookProof.HermiteGalerkin

theorem BookProof.ChapterSirkTrotterKato.galerkin_flow_transfer {A : H →L[ℂ] H} (hA : IsSelfAdjoint A)
    (b : HilbertBasis ℕ ℂ H) (v : H) {T₀ : ℝ} (hT₀ : 0 ≤ T₀) :
    TendstoUniformlyOn
      (fun m t => (ofBounded (galerkinCompression A b m)
        (isSelfAdjoint_galerkinCompression hA b m)).stoneU t v)
      (fun t => (ofBounded A hA).stoneU t v) atTop (Set.Icc (-T₀) T₀) := by sorry
