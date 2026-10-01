-- Generated from ChapterSirkTrotterKatoGalerkin.lean — theorem BookProof.ChapterSirkTrotterKato.galerkin_flow_tendsto
import Definitions.Def_ChapterUnitaryTransport
import Mathlib
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.HermiteGalerkin
open BookProof.ChapterSirkTrotterKato

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterUnitaryTransport


theorem BookProof.ChapterSirkTrotterKato.galerkin_flow_tendsto {A : H →L[ℂ] H} (hA : IsSelfAdjoint A)
    (b : HilbertBasis ℕ ℂ H) (v : H) (t : ℝ) :
    Tendsto (fun m => (ofBounded (galerkinCompression A b m)
      (isSelfAdjoint_galerkinCompression hA b m)).stoneU t v) atTop
      (𝓝 ((ofBounded A hA).stoneU t v)) := by sorry
